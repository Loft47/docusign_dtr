module DocusignDtr
  class QueryParamHelper
    # rubocop:disable Naming/PredicateName
    QUERY_PARAMS = {
      search: :search,
      count: :count,
      end_date: :endDate,
      start_position: :startPosition,
      room_status: :roomStatus,
      owned_only: :ownedOnly,
      transaction_side: :transactionSide,
      is_under_contract: :isUnderContract,
      region_id: :regionId,
      office_id: :officeId,
      has_submitted_task_list: :hasSubmittedTaskList,
      has_contract_amount: :hasContractAmount,
      sort: :sort,
      date_range_type: :dateRangeType,
      start_date: :startDate
    }.freeze

    class << self
      def call(options)
        @options = options
        QUERY_PARAMS.each_with_object({}) do |(key, value), memo|
          memo[value] = send(key) if @options.key? key
        end
      end

      def search
        @options[:search].to_s
      end

      def count
        @options[:count].to_i
      end

      def start_position
        @options[:start_position].to_i
      end

      def room_status
        raise "error: not acceptable value #{@options[:room_status]}" unless acceptable_value?(
          :room_status, @options[:room_status]
        )

        @options[:room_status].to_s
      end

      def owned_only
        to_boolean(@options[:owned_only])
      end

      def transaction_side
        raise "error: not acceptable value #{@options[:transaction_side]}" unless acceptable_value?(
          :transaction_side, @options[:transaction_side]
        )

        @options[:transaction_side].to_s
      end

      def is_under_contract
        to_boolean(@options[:is_under_contract])
      end

      def region_id
        @options[:region_id].to_i
      end

      def office_id
        @options[:office_id].to_i
      end

      def has_submitted_task_list
        to_boolean(@options[:has_submitted_task_list])
      end

      def has_contract_amount
        to_boolean(@options[:has_contract_amount])
      end

      def sort
        raise "error: not acceptable value #{@options[:sort]}" unless acceptable_value?(:sort, @options[:sort].to_s)

        @options[:sort].to_s
      end

      def date_range_type
        raise "error: not acceptable value #{@options[:date_range_type]}" unless acceptable_value?(
          :date_range_type, @options[:date_range_type]
        )

        @options[:date_range_type].to_s
      end

      def start_date
        to_date(@options[:start_date].to_s)
      end

      def end_date
        to_date(@options[:end_date].to_s)
      end

      def to_boolean(value)
        raise "error: #{value} is not a boolean value" unless !value.is_a?(FalseClass) || !value.is_a?(TrueClass)

        value
      end

      def to_date(value)
        DateTime.parse(value)
        value
      rescue ArgumentError
        "error: #{value} is not a valid date format"
      end

      def acceptable_value?(key, value)
        query_acceptable_values[key].include?(value)
      end

      def query_acceptable_values
        DocusignDtr::Models::Room::ACCEPTABLE_VALUES
      end
    end
  end
  # rubocop:enable Naming/PredicateName
end
