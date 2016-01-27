require 'rails_helper'

describe User do

  let(:user) { create(:user) }
  let(:attributes) do
    {
      :email => 'foo1234@bar.com',
      :username => 'foobar1234',
      :password => 'password'
    }
  end

  # ----------------------------------------
  # Validations
  # ----------------------------------------

  describe 'validations' do

    # ----------------------------------------
    # email
    # ----------------------------------------

    describe 'email' do

      it 'must contain a @ symbol' do
        attributes[:email] = 'asdf'
        user = User.new(attributes)
        expect { user.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    # ----------------------------------------
    # username
    # ----------------------------------------


    describe 'username' do

      it 'must have at least 8 chars' do
        attributes[:username] = 'a' * 7
        user = User.new(attributes)
        expect { user.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end


      it 'cannot have more than 32 chars' do
        attributes[:username] = 'a' * 33
        user = User.new(attributes)
        expect { user.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end


      it 'must be alpha numeric' do
        attributes[:username] = 'asdfasdf$'
        user = User.new(attributes)
        expect { user.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    # ----------------------------------------
    # password
    # ----------------------------------------

    describe 'password' do

      it 'must have at least 8 chars' do
        attributes[:password] = 'a' * 7
        user = User.new(attributes)
        expect { user.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end


      it 'cannot have more than 32 chars' do
        attributes[:password] = 'a' * 33
        user = User.new(attributes)
        expect { user.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end


      it 'cannot contain white space' do
        attributes[:password] = 'a asdfasdf'
        user = User.new(attributes)
        expect { user.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

  # ----------------------------------------
  # create_auth_token
  # ----------------------------------------

  describe '#create_auth_token' do
    it 'returns a string token' do
      expect(user.create_auth_token).to be_a(String)
    end


    it 'sets the auth token on the user' do
      user.create_auth_token
      expect(user.auth_token).to_not be_nil
    end
  end

  # ----------------------------------------
  # find_by_username_or_email
  # ----------------------------------------

  describe '#find_by_username_or_email' do
    it 'returns a user when the email matches' do
      expect(User.find_by_username_or_email(user.email)).to eq(user)
    end


    it 'returns a user when the username matches' do
      expect(User.find_by_username_or_email(user.username)).to eq(user)
    end


    it 'returns nil when neither the email nor username matches' do
      expect(User.find_by_username_or_email('Snakes')).to be_nil
    end
  end

  # ----------------------------------------
  # callbacks
  # ----------------------------------------

  describe 'callbacks' do

    # ----------------------------------------
    # after create
    # ----------------------------------------

    describe 'after create' do

      it 'calls #create_auth_token' do
        user = User.new(attributes)
        expect(user).to receive(:create_auth_token)
        user.save!
      end
    end

    # ----------------------------------------
    # before destroy
    # ----------------------------------------

    describe 'before destroy' do

      it 'raises an error if the user is the last user in the database' do
        expect { user.destroy! }.to raise_error(ActiveRecord::RecordNotDestroyed)
      end


      it 'does not raise an error if the user is not the last' do
        user
        another_user = User.new(attributes)
        another_user.save!
        expect { user.destroy! }.to_not raise_error
      end
    end
  end
end

