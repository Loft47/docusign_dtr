module DocusignDtr
  class QueryParamHelper
    # rubocop:disable Naming/PredicateName
    QUERY_PARAMS = {
      search: :search,
      count: :count,
      endDate: :end_date,
      startPosition: :start_position,
      roomStatus: :room_status,
      ownedOnly: :owned_only,
      transactionSide: :transaction_side,
      isUnderContract: :is_under_contract,
      regionId: :region_id,
      officeId: :office_id,
      hasSubmittedTaskList: :has_submitted_task_list,
      hasContractAmount: :has_contract_amount,
      sort: :sort,
      dateRangeType: :date_range_type,
      startDate: :start_date
    }.freeze

    class << self
      def call(options)
        @options = options
        QUERY_PARAMS.each_with_object({}) do |(key, value), memo|
          memo[key] = send(value) if @options.key? key
        end
      end

      def search
        @options[:search].to_s
      end

      def count
        @options[:count].to_i
      end

      def start_position
        @options[:startPosition].to_i
      end

      def room_status
        raise "error: not acceptable value #{@options[:roomStatus]}" unless acceptable_value?(
          :roomStatus, @options[:roomStatus]
        )

        @options[:roomStatus].to_s
      end

      def owned_only
        to_boolean(@options[:ownedOnly])
      end

      def transaction_side
        raise "error: not acceptable value #{@options[:transactionSide]}" unless acceptable_value?(
          :transactionSide, @options[:transactionSide]
        )

        @options[:transactionSide].to_s
      end

      def is_under_contract
        to_boolean(@options[:isUnderContract])
      end

      def region_id
        @options[:regionId].to_i
      end

      def office_id
        @options[:officeId].to_i
      end

      def has_submitted_task_list
        to_boolean(@options[:hasSubmittedTaskList])
      end

      def has_contract_amount
        to_boolean(@options[:hasContractAmount])
      end

      def sort
        raise "error: not acceptable value #{@options[:sort]}" unless acceptable_value?(:sort, @options[:sort].to_s)

        @options[:sort].to_s
      end

      def date_range_type
        raise "error: not acceptable value #{@options[:dateRangeType]}" unless acceptable_value?(
          :dateRangeType, @options[:dateRangeType]
        )

        @options[:dateRangeType].to_s
      end

      def start_date
        to_date(@options[:startDate].to_s)
      end

      def end_date
        to_date(@options[:endDate].to_s)
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
