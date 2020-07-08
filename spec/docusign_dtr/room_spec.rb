require_relative '../spec_helper'

RSpec.describe DocusignDtr::Room do
  let(:client) { DocusignDtr::Client.new(token: SecureRandom.uuid) }
  subject { DocusignDtr::Room.new(client: client) }

  describe '#initialize' do
    it { expect(subject.client).to eq client }
    it { expect { DocusignDtr::Room.new }.to raise_error(StandardError) }
  end

  before(:each) { docusign_mock_batch(:rooms) }
  describe '#all' do
    it 'returns array of rooms' do
      expect(subject).to receive(:batch).and_call_original
      rooms = subject.all
      expect(rooms.size).to eq(16)
      expect(rooms).to all(be_a(DocusignDtr::Models::Room))
      expect(rooms.first).to have_attributes(
        address: have_attributes(
          address1: '2200 Z 4th Ave',
          address2: nil,
          city: 'T',
          county: nil,
          state_id: 'CA-NU',
          postal_code: nil,
          country_id: 'CA',
          time_zone_id: nil
        ),
        auction_details: nil,
        closed_status_id: '',
        company_room_status_id: nil,
        contract_amount: nil,
        created_date: '2018-07-31T00:28:32.43',
        creation_details: nil,
        details: nil,
        integrator_data: nil,
        is_under_contract: false,
        last_updated_date: nil,
        latitude: 0,
        lone_wolf_details: nil,
        longitude: 0,
        mls_id: '1477962019',
        office_id: 1_150,
        owners: [have_attributes(
          first_name: 'Manny',
          last_name: 'Manager',
          office_id: 1_150,
          transaction_side_id: 'listbuy',
          user_id: 102_286
        )],
        room_id: 88_640,
        room_image_url: nil,
        room_name: 'Abshire',
        status: 'Active',
        view_link: nil
      )
    end

    it 'accepts additional parameters' do
      ENV['TZ'] = 'America/Toronto'
      expect(client).to receive(:get).with(
        '/rooms',
        count: 10,
        startPosition: 10,
        search: '1234',
        endDate: '1999-12-31T23:59:59-05:00',
        roomStatus: 'Active',
        ownedOnly: false,
        transactionSide: 'buy',
        isUnderContract: false,
        regionId: 123,
        officeId: 1,
        hasSubmittedTaskList: false,
        hasContractAmount: false,
        sort: 'RoomName',
        dateRangeType: 'Created',
        startDate: '1999-01-01T00:00:01-05:00'
      ).and_return('rooms' => [])
      subject.all(
        count: 10,
        start_position: 10,
        search: '1234',
        end_date: '1999-12-31 23:59:59',
        room_status: 'Active',
        owned_only: false,
        transaction_side: 'buy',
        is_under_contract: false,
        region_id: 123,
        office_id: 1,
        has_submitted_task_list: false,
        has_contract_amount: false,
        sort: 'RoomName',
        date_range_type: 'Created',
        start_date: '1999-01-01 00:00:01'
      )
    end
  end

  describe '#query_params' do
    it 'raise an error when room_status is invalid' do
      expect { subject.all(room_status: 'Wrong') }.to raise_error(
        DocusignDtr::InvalidParameter, 'value Wrong is not valid for room_status'
      )
    end

    it 'raise an error when transaction_side is invalid' do
      expect { subject.all(transaction_side: 'Wrong') }.to raise_error(
        DocusignDtr::InvalidParameter, 'value Wrong is not valid for transaction_side'
      )
    end

    it 'raise an error when sort is invalid' do
      expect { subject.all(sort: 'Wrong') }.to raise_error(
        DocusignDtr::InvalidParameter, 'value Wrong is not valid for sort'
      )
    end

    it 'raise an error when start_date is invalid' do
      expect { subject.all(start_date: 'Wrong') }.to raise_error(
        DocusignDtr::InvalidParameter, 'Wrong is not a valid start_date'
      )
    end

    it 'raise an error when end_date is invalid' do
      expect { subject.all(end_date: 'Wrong') }.to raise_error(
        DocusignDtr::InvalidParameter, 'Wrong is not a valid end_date'
      )
    end

    it 'raise an error when owned_only is invalid' do
      expect { subject.all(owned_only: 'Wrong') }.to raise_error(
        DocusignDtr::InvalidParameter, 'value Wrong is not valid for owned_only'
      )
    end

    it 'raise an error when is_under_contract is invalid' do
      expect { subject.all(is_under_contract: 'Wrong') }.to raise_error(
        DocusignDtr::InvalidParameter, 'value Wrong is not valid for is_under_contract'
      )
    end

    it 'raise an error when has_submitted_task_list is invalid' do
      expect { subject.all(has_submitted_task_list: 'Wrong') }.to raise_error(
        DocusignDtr::InvalidParameter, 'value Wrong is not valid for has_submitted_task_list'
      )
    end

    it 'raise an error when has_contract_amount is invalid' do
      expect { subject.all(has_contract_amount: 'Wrong') }.to raise_error(
        DocusignDtr::InvalidParameter, 'value Wrong is not valid for has_contract_amount'
      )
    end
  end

  describe '#find' do
    it 'returns one room object' do
      docusign_mock(:room)
      room_data = subject.find(123)
      expect(room_data).to be_a(DocusignDtr::Models::Room)
      expect(room_data).to have_attributes(
        address: have_attributes(
          address1: '2200 Z 4th Ave',
          address2: '6542 Predovic Corner',
          city: 'New Augusta',
          country_id: 'CA',
          county: 'Willow Creek',
          postal_code: '72675',
          state_id: 'CA-NU',
          time_zone_id: nil
        ),
        auction_details: have_attributes(
          buyers_premium: 400.0,
          contract_sent_to_seller_date: '2018-09-10T03:00:00Z',
          deed_recvd_from_seller_date: '2018-09-24T03:00:00Z',
          deed_sent_to_seller_date: '2018-09-14T03:00:00Z',
          item_number: '123',
          prelim_hud_recvd_from_seller_date: '2018-09-28T03:00:00Z',
          prelim_hud_sent_seller_date: '2018-09-26T03:00:00Z',
          seller_decision_type_id: 'pend',
          seller_executed_contract_date: '2018-09-12T03:00:00Z',
          subject_to_decision_date: '2018-09-28T03:00:00Z',
          subject_to_decision_id: nil,
          subject_to_seller_conf: true,
          total_purchase_price: 35_000.0,
          winning_bid: 2_000.0
        ),
        closed_status_id: nil,
        company_room_status_id: nil,
        contract_amount: nil,
        created_date: nil,
        creation_details: have_attributes(
          user_id: 102_286,
          first_name: 'Manny',
          last_name: 'Manager',
          created: '2018-07-30T21:34:55.157'
        ),
        details: have_attributes(
          actual_close_date: '2018-10-31T00:00:00',
          api_client_data: nil,
          appraisal_contingency_date: '2018-10-16T03:00:00',
          bathrooms: 2.0,
          bedrooms: 2,
          binding_date: '2018-10-17T00:00:00',
          buyer1: have_attributes(
            address1: '23794 Nienow Meadows',
            address2: '60923 Denesik Divide',
            business_phone: '(128) 006-7875',
            cell_phone: '1-526-639-0819',
            city: 'North Estrella',
            company: 'Lang Inc',
            contact_index: nil,
            country_id: 'CA',
            email: 'felicity_cormier@goyette.biz',
            home_phone: '1-230-950-8252',
            name: 'Mafalda Beier',
            phone: nil,
            postal_code: '97467',
            room_contact_id: nil,
            room_contact_type: nil,
            room_contact_type_id: nil,
            room_id: nil,
            side: nil,
            state_id: 'CA-NU'
          ),
          buyer2: have_attributes(
            address1: '54449 Dulce Streets',
            address2: '6659 Heathcote Rapids',
            business_phone: '(658) 832-2264',
            cell_phone: '1-259-517-4077',
            city: 'West Travis',
            company: 'Bechtelar-Marvin',
            contact_index: nil,
            country_id: 'CA',
            email: 'jacques@lockman.name',
            home_phone: '1-400-025-2126 x482',
            name: 'Winnifred Cruickshank',
            phone: nil,
            postal_code: '87594',
            room_contact_id: nil,
            room_contact_type: nil,
            room_contact_type_id: nil,
            room_id: nil,
            side: nil,
            state_id: 'CA-BC'
          ),
          buyer_agent1_email: 'lilyan@beier.info',
          buyer_agent1_name: 'Johnathan Lowe Jr.',
          buyer_agent1_phone: '288-113-8290',
          buyer_agent2_company: 'Witting-Friesen',
          buyer_agent2_email: 'nils@goldner.co',
          buyer_agent2_name: 'Ms. Reyes Hills',
          buyer_agent2_phone: '1-522-578-4352 x473',
          buyer_side_commission: 33.0,
          closed_date: nil,
          closed_status_id: '',
          comment: 'This is a nice and loong text comment :)',
          company_address1: nil,
          company_address2: nil,
          company_city: nil,
          company_contact_name: nil,
          company_email: nil,
          company_id: 1125,
          company_phone: nil,
          company_postal_code: nil,
          company_state: nil,
          contingency_removal_date: '2018-10-17T00:00:00',
          contract_amount: 30_000.0,
          contract_date: '2018-09-15T00:00:00',
          current_listing_amount: 1200.0,
          date_submitted_for_review: nil,
          earnest_money_amount: 1500.0,
          entity_holding_earnest_money: 'The Bank',
          escrow_provider: nil,
          expected_closing_date: '2018-10-31T00:00:00',
          financing_type_id: 'bc',
          garages: 2.0,
          home_warranty_provider: nil,
          inspection_contingency_date: '2018-09-28T03:00:00',
          insurance_provider: nil,
          internal_referral: 'Ciclano',
          internal_referral_percentage: 10.0,
          is_under_contract: true,
          latitude: 0.0,
          list_side_commission: 33.0,
          listing_agent1_company: 'Halvorson, Ratke and Jaskolski',
          listing_agent1_email: 'maximillia@kohler.co',
          listing_agent1_name: 'Robbie Bechtelar',
          listing_agent1_phone: '1-956-840-0048 x5236',
          listing_agent2_company: 'Bernhard, Wisozk and Stehr',
          listing_agent2_email: 'audra@bins.net',
          listing_agent2_name: 'Elaina Mohr',
          listing_agent2_phone: '829-882-9097 x06799',
          listing_date: '2018-09-01T00:00:00',
          listing_expiration_date: '2018-11-30T00:00:00',
          loan_contingency_date: '2018-10-18T03:00:00',
          local_contract_amount: 75.25,
          local_currency_id: 'CAD',
          local_current_listing_amount: nil,
          local_earnest_money_amount: 50.1,
          local_original_listing_amount: nil,
          longitude: 0.0,
          lot_size: '14',
          mls_id: '5559876',
          mortgage_provider: nil,
          offer_date: '2018-09-02T00:00:00',
          office_id: nil,
          origin_of_lead_id: 'aw',
          original_listing_amount: 1000.0,
          outside_referral: 'Fulano',
          outside_referral_percentage: 33.0,
          property_type_id: 'comm',
          rejected_date: nil,
          relisting: true,
          room_contacts: [
            have_attributes(
              address1: "66872 O'Hara Terrace",
              address2: '6045 Hailey Shoals',
              business_phone: '452.631.6503 x70415',
              cell_phone: '482.425.2235',
              city: 'Alessiafort',
              company: 'Stanton, Carroll and Howe',
              contact_index: 1,
              country_id: 'CA',
              email: 'lilyan@beier.info',
              home_phone: nil,
              name: 'Johnathan Lowe Jr.',
              phone: '288-113-8290',
              postal_code: '62184-3383',
              room_contact_id: 59_136,
              room_contact_type: nil,
              room_contact_type_id: 'buyagent',
              room_id: 88_593,
              side: nil,
              state_id: 'CA-ON'
            ),
            have_attributes(
              address1: '1783 Barton Mission',
              address2: '72515 Jeanne Springs',
              business_phone: '305.554.6734',
              cell_phone: '631-580-5021',
              city: 'Douglasmouth',
              company: 'Witting-Friesen',
              contact_index: 2,
              country_id: 'CA',
              email: 'nils@goldner.co',
              home_phone: nil,
              name: 'Ms. Reyes Hills',
              phone: '1-522-578-4352 x473',
              postal_code: '16129',
              room_contact_id: 59_137,
              room_contact_type: nil,
              room_contact_type_id: 'buyagent',
              room_id: 88_593,
              side: nil,
              state_id: 'CA-QC'
            ),
            have_attributes(
              address1: '23794 Nienow Meadows',
              address2: '60923 Denesik Divide',
              business_phone: '(128) 006-7875',
              cell_phone: '1-526-639-0819',
              city: 'North Estrella',
              company: 'Lang Inc',
              contact_index: 1,
              country_id: 'CA',
              email: 'felicity_cormier@goyette.biz',
              home_phone: nil,
              name: 'Mafalda Beier',
              phone: '1-230-950-8252',
              postal_code: '97467',
              room_contact_id: 59_122,
              room_contact_type: nil,
              room_contact_type_id: 'buyer',
              room_id: 88_593,
              side: nil,
              state_id: 'CA-NU'
            ),
            have_attributes(
              address1: '54449 Dulce Streets',
              address2: '6659 Heathcote Rapids',
              business_phone: '(658) 832-2264',
              cell_phone: '1-259-517-4077',
              city: 'West Travis',
              company: 'Bechtelar-Marvin',
              contact_index: 2,
              country_id: 'CA',
              email: 'jacques@lockman.name',
              home_phone: nil,
              name: 'Winnifred Cruickshank',
              phone: '1-400-025-2126 x482',
              postal_code: '87594',
              room_contact_id: 59_123,
              room_contact_type: nil,
              room_contact_type_id: 'buyer',
              room_id: 88_593,
              side: nil,
              state_id: 'CA-BC'
            ),
            have_attributes(
              address1: '524 Yost Courts',
              address2: '8485 Nelle Row',
              business_phone: '(933) 373-9454',
              cell_phone: '672.507.7844',
              city: 'Cynthiaborough',
              company: 'Rippin, Yost and Jakubowski',
              contact_index: 1,
              country_id: 'CA',
              email: 'carlie@macejkovic.com',
              home_phone: nil,
              name: 'Adrienne Koch PhD',
              phone: '974.166.3940 x371',
              postal_code: '32403',
              room_contact_id: 59_124,
              room_contact_type: nil,
              room_contact_type_id: 'escprvdr',
              room_id: 88_593,
              side: nil,
              state_id: 'CA-BC'
            ),
            have_attributes(
              address1: '2350 Sawayn Trail',
              address2: '769 Sally Flats',
              business_phone: '1-158-596-1902',
              cell_phone: '(413) 776-7892',
              city: 'Lake Sigmund',
              company: 'Sawayn Group',
              contact_index: 1,
              country_id: 'CA',
              email: 'berta.zemlak@windleroconnell.io',
              home_phone: nil,
              name: 'Angelo Turner',
              phone: '1-118-636-8694x55542',
              postal_code: '43615-8050',
              room_contact_id: 59_125,
              room_contact_type: nil,
              room_contact_type_id: 'hmwprvdr',
              room_id: 88_593,
              side: nil,
              state_id: 'CA-BC'
            ),
            have_attributes(
              address1: '537 Littel Skyway',
              address2: '7400 Ebba Mews',
              business_phone: '1-523-473-2308',
              cell_phone: '563.368.8475',
              city: 'West Travis',
              company: 'Cronin Inc',
              contact_index: 1,
              country_id: 'US',
              email: 'loma.ondricka@gottlieb.biz',
              home_phone: nil,
              name: 'Alyce Hagenes',
              phone: '268.782.8200 x26532',
              postal_code: '39511-6088',
              room_contact_id: 59_126,
              room_contact_type: nil,
              room_contact_type_id: 'insprvdr',
              room_id: 88_593,
              side: nil,
              state_id: 'US-CO'
            ),
            have_attributes(
              address1: '509 Gaylord Flats',
              address2: '71453 Mylene Forest',
              business_phone: '367.977.3309',
              cell_phone: '276-655-7349',
              city: 'Deckowtown',
              company: 'Halvorson, Ratke and Jaskolski',
              contact_index: 1,
              country_id: 'US',
              email: 'maximillia@kohler.co',
              home_phone: nil,
              name: 'Robbie Bechtelar',
              phone: '1-956-840-0048 x5236',
              postal_code: '89654-0302',
              room_contact_id: 59_127,
              room_contact_type: nil,
              room_contact_type_id: 'lisagent',
              room_id: 88_593,
              side: nil,
              state_id: 'US-FL'
            ),
            have_attributes(
              address1: '61580 Dortha Fields',
              address2: '7136 Gage Stream',
              business_phone: '283-225-4359',
              cell_phone: '(834) 392-4215',
              city: 'Lake Laurel',
              company: 'Bernhard, Wisozk and Stehr',
              contact_index: 2,
              country_id: 'US',
              email: 'audra@bins.net',
              home_phone: nil,
              name: 'Elaina Mohr',
              phone: '829-882-9097 x06799',
              postal_code: '84425',
              room_contact_id: 59_128,
              room_contact_type: nil,
              room_contact_type_id: 'lisagent',
              room_id: 88_593,
              side: nil,
              state_id: 'US-FL'
            ),
            have_attributes(
              address1: '779 Lila Lights',
              address2: '6624 Pamela Ford',
              business_phone: '1-569-420-9186',
              cell_phone: '(473) 088-5158',
              city: 'Laronside',
              company: 'Bergstrom, Lueilwitz and Heathcote',
              contact_index: 1,
              country_id: 'US',
              email: 'dalton@yundt.com',
              home_phone: nil,
              name: 'Dr. Tod Heidenreich',
              phone: '216-172-1486 x7658',
              postal_code: '73776-6422',
              room_contact_id: 59_129,
              room_contact_type: nil,
              room_contact_type_id: 'mrtprvdr',
              room_id: 88_593,
              side: nil,
              state_id: 'US-CA'
            ),
            have_attributes(
              address1: '9727 Maxime Meadows',
              address2: '28517 Diamond Circle',
              business_phone: '624-436-7754',
              cell_phone: '838-515-6903',
              city: 'Garrickbury',
              company: 'Terry LLC',
              contact_index: 1,
              country_id: 'CA',
              email: 'joanny.medhurst@stehr.org',
              home_phone: nil,
              name: 'Eldridge Torphy',
              phone: '417.842.2740',
              postal_code: '44356',
              room_contact_id: 59_130,
              room_contact_type: nil,
              room_contact_type_id: 'seller',
              room_id: 88_593,
              side: nil,
              state_id: 'CA-BC'
            ),
            have_attributes(
              address1: '97662 Colby Underpass',
              address2: '540 Reichert Square',
              business_phone: '1-342-141-0625',
              cell_phone: '380-634-0141',
              city: 'Lake Florencio',
              company: 'Wisoky and Sons',
              contact_index: 2,
              country_id: 'CA',
              email: 'destiny@dare.co',
              home_phone: nil,
              name: 'Loyce Williamson',
              phone: '(229) 357-9464 x0031',
              postal_code: '19853',
              room_contact_id: 59_131,
              room_contact_type: nil,
              room_contact_type_id: 'seller',
              room_id: 88_593,
              side: nil,
              state_id: 'CA-BC'
            ),
            have_attributes(
              address1: '258 Graham Fall',
              address2: '52871 Blanda Plains',
              business_phone: '712.321.4278 x2190',
              cell_phone: '(255) 117-2846',
              city: 'North Vincemouth',
              company: 'Rath-Feest',
              contact_index: 1,
              country_id: 'CA',
              email: 'charles@jenkins.name',
              home_phone: nil,
              name: 'Rowena Weissnat',
              phone: '762-922-7685',
              postal_code: '22494',
              room_contact_id: 59_132,
              room_contact_type: nil,
              room_contact_type_id: 'srvprvdr',
              room_id: 88_593,
              side: nil,
              state_id: 'CA-BC'
            ),
            have_attributes(
              address1: '91682 Grimes Courts',
              address2: '2403 Frami Manor',
              business_phone: '(837) 735-9656',
              cell_phone: '(691) 101-5549',
              city: 'New Wanda',
              company: 'Bosco Inc',
              contact_index: 1,
              country_id: 'CA',
              email: 'benton_lubowitz@torp.org',
              home_phone: nil,
              name: 'Evelyn Brakus',
              phone: '(555) 196-6967',
              postal_code: '52780',
              room_contact_id: 59_133,
              room_contact_type: nil,
              room_contact_type_id: 'ttlprvdr',
              room_id: 88_593,
              side: nil,
              state_id: 'CA-BC'
            )
          ],
          rooms: 2,
          seller1: have_attributes(
            company: 'Terry LLC',
            email: 'joanny.medhurst@stehr.org',
            name: 'Eldridge Torphy',
            home_phone: '417.842.2740',
            cell_phone: '838-515-6903',
            business_phone: '624-436-7754',
            address1: '9727 Maxime Meadows',
            address2: '28517 Diamond Circle',
            city: 'Garrickbury',
            state_id: 'CA-BC',
            postal_code: '44356',
            country_id: 'CA'
          ),
          seller2: have_attributes(
            company: 'Wisoky and Sons',
            email: 'destiny@dare.co',
            name: 'Loyce Williamson',
            home_phone: '(229) 357-9464 x0031',
            cell_phone: '380-634-0141',
            business_phone: '1-342-141-0625',
            address1: '97662 Colby Underpass',
            address2: '540 Reichert Square',
            city: 'Lake Florencio',
            state_id: 'CA-BC',
            postal_code: '19853',
            country_id: 'CA'
          ),
          seller_concession: 150.25,
          special_circumstances_id: 'hist',
          sq_ft: '120.25',
          survey_provider: nil,
          taxes: 40,
          title_provider: nil,
          units: nil,
          year_built: 2_010
        ),
        integrator_data: nil,
        last_updated_date: '2018-09-30T00:45:51.853',
        lone_wolf_details: have_attributes(
          external_agent_commission: {
            'email_addresses' => nil
          },
          is_lone_wolf_enabled: false,
          lone_wolf_id: nil,
          agent_commission: have_attributes(
            agent_id: nil,
            commission: nil,
            end_code: nil,
            end_count: nil
          ),
          agent_commission2: have_attributes(
            agent_id: nil,
            commission: nil,
            end_code: nil,
            end_count: nil
          ),
          business_contact: have_attributes(
            address1: nil,
            address2: nil,
            business_phone: nil,
            cell_phone: nil,
            city: nil,
            company: nil,
            contact_index: nil,
            country_id: nil,
            email: nil,
            home_phone: nil,
            name: nil,
            phone: nil,
            postal_code: nil,
            room_contact_id: nil,
            room_contact_type: nil,
            room_contact_type_id: nil,
            room_id: nil,
            side: nil,
            state_id: nil
          ),
          client_contact: have_attributes(
            address1: nil,
            address2: nil,
            business_phone: nil,
            cell_phone: nil,
            city: nil,
            company: nil,
            contact_index: nil,
            country_id: nil,
            email: nil,
            home_phone: nil,
            name: nil,
            phone: nil,
            postal_code: nil,
            room_contact_id: nil,
            room_contact_type: nil,
            room_contact_type_id: nil,
            room_id: nil,
            side: nil,
            state_id: nil
          )
        ),
        longitude: nil,
        mls_id: nil,
        office_id: nil,
        owners: [
          have_attributes(
            first_name: 'Manny',
            last_name: 'Manager',
            office_id: 1150,
            transaction_side_id: 'listbuy',
            user_id: 102_286
          )
        ],
        room_id: 88_593,
        room_image_url: nil,
        room_name: 'The Room',
        status: 'Active',
        view_link: 'https://demo.rooms.docusign.com/transaction/88593'
      )
    end
  end

  describe '#create' do
    skip
  end

  describe '#destroy' do
    skip
  end

  describe '#update' do
    skip
  end
end
