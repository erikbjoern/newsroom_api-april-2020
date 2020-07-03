RSpec.describe Article, type: :model do
  describe 'Database table' do
    it { is_expected.to have_db_column :title }
    it { is_expected.to have_db_column :body  }
    it { is_expected.to have_db_column :category }
  end

  describe 'Validates' do
    it { is_expected.to validate_presence_of :title }
    it { is_expected.to validate_presence_of :body  }
    it { is_expected.to validate_presence_of :category }
  end

  describe 'Factory' do
    it 'should have valid Factory' do
      expect(create(:article)).to be_valid
    end
  end
end
