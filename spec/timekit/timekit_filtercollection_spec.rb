# frozen_string_literal: true

describe Timekit::Filtercollection do
  before(:each) do
    subject { Timekit::Filtercollection.new }
  end

  describe '#initialize' do
    it 'must have blank conditions' do
      expect(subject.as_json).to eq(
        or: [],
        and: [],
        after: []
      )
    end
  end

  context 'when after take' do
    describe '#after_take_random' do
      it 'takes' do
        subject.after_take_random(1)
        expect(subject.as_json[:after]).to eq(
          [take_random: { number: 1 }]
        )
      end
    end

    describe '#after_take_first' do
      it 'takes' do
        subject.after_take_first(1)
        expect(subject.as_json[:after]).to eq(
          [take_first: { number: 1 }]
        )
      end
    end

    describe '#after_take_last' do
      it 'takes' do
        subject.after_take_last(1)
        expect(subject.as_json[:after]).to eq(
          [take_last: { number: 1 }]
        )
      end
    end
  end

  describe '#and_only_during_business_hours' do
    context 'when timezone provided' do
      it 'must occur during business hours with timezone' do
        subject.and_only_during_business_hours('America/Toronto')
        expect(subject.as_json[:and]).to eq(
          [{ business_hours: { timezone: 'America/Toronto' } }]
        )
      end
    end

    context 'when no timezone provided' do
      it 'must occur during business hours without timezone' do
        subject.and_only_during_business_hours
        expect(subject.as_json[:and]).to eq(
          [{ business_hours: {} }]
        )
      end
    end
  end

  describe '#and_not_on_weekends' do
    context 'when timezone provided' do
      it 'must exclude weekends with timezone' do
        subject.and_not_on_weekends('America/Toronto')
        expect(subject.as_json[:and]).to eq(
          [{ exclude_weekends: { timezone: 'America/Toronto' } }]
        )
      end
    end

    context 'when no timezone provided' do
      it 'must exclude weekends without timezone' do
        subject.and_not_on_weekends
        expect(subject.as_json[:and]).to eq(
          [{ exclude_weekends: {} }]
        )
      end
    end
  end

  describe '#and_on_day' do
    context 'when day is valid' do
      it 'must add day' do
        subject.and_on_day('Monday')
        expect(subject.as_json[:and]).to eq(
          [{ specific_day: { day: 'Monday' } }]
        )
      end
    end

    context 'when day is invalid' do
      it 'must raise' do
        expect { subject.and_on_day('Munday') }
          .to raise_error('Invalid day Munday')
      end
    end
  end

  describe '#or_on_any_days' do
    context 'when days are valid' do
      it 'must add days' do
        subject.or_on_any_days(%w[Monday Tuesday])
        expect(subject.as_json[:or]).to eq(
          [
            { specific_day: { day: 'Monday' } },
            { specific_day: { day: 'Tuesday' } }
          ]
        )
      end
    end

    context 'when days are invalid' do
      it 'must raise' do
        expect { subject.or_on_any_days(%w[Munday Tuesday]) }
          .to raise_error('Invalid day Munday')
      end
    end
  end

  describe '#or_between_times' do
    it 'must add to or conditions' do
      timestamp1 = Date.today
      timestamp2 = Date.today + 1
      subject.or_between_times(timestamp1, timestamp2)
      expect(subject.as_json[:or]).to eq(
        [between_timestamps: {
          start: timestamp1,
          end: timestamp2
        }]
      )
    end
  end
end
