module DocusignDtr
  # rubocop:disable Metrics/ClassLength
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
          memo[key] = send(value) if @options.key? value
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
        raise "error: not acceptable value #{@options[:room_status]}" unless %w[
          Active
          Pending
          Closed
          Open
        ].include? @options[:room_status].to_s
        @options[:room_status].to_s
      end

      def owned_only
        to_boolean(@options[:owned_only])
      end

      def transaction_side
        raise "error: not acceptable value #{value}" unless %w[
          buy
          sell
          listbuy
          refi
        ].include? @options[:transaction_side].to_s
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
        raise "error: not acceptable value #{@options[:sort]}" unless [
          'RoomName',
          'RoomName desc',
          'CreatedDate',
          'CreatedDate desc',
          'ExpectedClosingDate',
          'ExpectedClosingDate desc',
          'LastUpdatedDate',
          'LastUpdatedDate desc',
          'ClosedDate',
          'ClosedDate desc'
        ].include? @options[:sort].to_s
        @options[:sort].to_s
      end

      def date_range_type
        raise "error: not acceptable value #{value}" unless %w[
          Created
          LastUpdated
          Closed
        ].include? @options[:date_range_type]
        @options[:date_range_type].to_s
      end

      def start_date
        to_date(@options[:start_date].to_s)
      end

      def end_date
        to_date(@options[:end_date].to_s)
      end

      def to_boolean(value)
        raise "error: #{value} is not a boolean value" unless value.is_a? Boolean
        value
      end

      # rubocop:disable Style/DateTime
      def to_date(value)
        DateTime.parse(value)
        value
      rescue ArgumentError
        "error: #{value} is not a valid date format"
      end
      # rubocop:enable Style/DateTime
    end
  end
  # rubocop:enable Naming/PredicateName
end
# rubocop:enable Metrics/ClassLength
