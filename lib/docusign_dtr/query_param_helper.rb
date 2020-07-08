module DocusignDtr
  # rubocop:disable Metrics/ClassLength
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
        unless acceptable_value?(:room_status, @options[:room_status])
          raise DocusignDtr::InvalidParameter.new("value #{@options[:room_status]} is not valid for #{__method__}")
        end

        @options[:room_status].to_s
      end

      def owned_only
        to_boolean(@options[:owned_only], __method__)
      end

      def transaction_side
        unless acceptable_value?(:transaction_side, @options[:transaction_side])
          raise DocusignDtr::InvalidParameter.new("value #{@options[:transaction_side]} is not valid for #{__method__}")
        end

        @options[:transaction_side].to_s
      end

      def is_under_contract
        to_boolean(@options[:is_under_contract], __method__)
      end

      def region_id
        @options[:region_id].to_i
      end

      def office_id
        @options[:office_id].to_i
      end

      def has_submitted_task_list
        to_boolean(@options[:has_submitted_task_list], __method__)
      end

      def has_contract_amount
        to_boolean(@options[:has_contract_amount], __method__)
      end

      def sort
        unless acceptable_value?(:sort, @options[:sort].to_s)
          raise DocusignDtr::InvalidParameter.new("value #{@options[:sort]} is not valid for #{__method__}")
        end

        @options[:sort].to_s
      end

      def date_range_type
        unless acceptable_value?(:date_range_type, @options[:date_range_type])
          raise DocusignDtr::InvalidParameter.new(
            "value #{@options[:date_range_type]} is not valid for #{__method__}"
          )
        end

        @options[:date_range_type].to_s
      end

      def start_date
        to_date(@options[:start_date].to_s, __method__)
      end

      def end_date
        to_date(@options[:end_date].to_s, __method__)
      end

      def to_boolean(value, key)
        unless value.is_a?(FalseClass) || value.is_a?(TrueClass)
          raise DocusignDtr::InvalidParameter.new("value #{value} is not valid for #{key}")
        end

        value
      end

      def to_date(value, key)
        date = Time.parse(value)
        date.iso8601
      rescue ArgumentError
        raise DocusignDtr::InvalidParameter.new("#{value} is not a valid #{key}")
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
  # rubocop:enable Metrics/ClassLength
end
