require 'rails_helper'

describe UsersController do

  let(:user) { create(:user) }

  # ----------------------------------------
  # GET index
  # ----------------------------------------

  describe 'GET #index' do

    context 'the user is not logged in' do
      it 'redirects' do
        get :index
        expect(response).to redirect_to login_path
      end
    end


    context 'the user is logged in' do

      before do
        login(user)
      end

      it 'renders the index template' do
        get :index
        expect(response).to render_template(:index)
      end


      it 'assigns the entire user collection as an instance variable' do
        get :index
        expect(assigns[:users]).to eq(User.all)
      end
    end
  end

  # ----------------------------------------
  # GET show
  # ----------------------------------------

  describe 'GET #show' do

    context 'the user is not logged in' do

      it 'redirects' do
        get :show, :id => 1
        expect(response).to redirect_to login_path
      end
    end


    context 'the user is logged in' do

      before do
        login(user)
      end

      it 'renders the show template' do
        get :show, :id => 1
        expect(response).to render_template(:show)
      end


      it 'assigns the user as an instance variable' do
        get :show, :id => 1
        expect(assigns[:user]).to eq(user)
      end
    end
  end

  # ----------------------------------------
  # GET new
  # ----------------------------------------

  describe 'GET #new' do

    context 'the user is not logged in' do

      it 'redirects' do
        get :new
        expect(response).to redirect_to login_path
      end
    end


    context 'the user is logged in' do

      before do
        login(user)
      end

      it 'renders the new template' do
        get :new
        expect(response).to render_template(:new)
      end


      it 'assigns a new user to an instance variable' do
        get :new
        expect(assigns[:user]).to_not be_persisted
      end
    end
  end

  # ----------------------------------------
  # GET edit
  # ----------------------------------------

  describe 'GET #edit' do

    context 'the user is not logged in' do
      
      it 'redirects' do
        get :edit, :id => 1
        expect(response).to redirect_to login_path
      end
    end


    context 'the user is logged in' do

      before do
        login(user)
      end

      context 'the current user is the user being edited' do

        it 'renders the edit template' do
          get :edit, :id => 1
          expect(response).to render_template(:edit)
        end


        it 'assigns the user with the given id to an instance variable' do
          get :edit, :id => 1
          expect(assigns[:user].id).to eq(1)
        end
      end


      context 'the current user is not the user being edited' do

        it 'redirects' do
          logout
          another_user = create(:user)
          login(another_user)
          get :edit, :id => 1
          expect(response).to redirect_to root_path
        end
      end
    end
  end

  # ----------------------------------------
  # POST create
  # ----------------------------------------

  describe 'POST #create' do
    context 'the user is not logged in' do
      it 'redirects'
      it 'does not create the user'
    end


    context 'the user is logged in' do
      it 'creates the user'
    end
  end

  # ----------------------------------------
  # PUT update
  # ----------------------------------------

  describe 'PUT #update' do
    context 'the user is not logged in' do
      it 'redirects'
      it 'does not update the user'
    end


    context 'the user is logged in' do

      context 'the current user is the user being updated' do
        it 'updates the user'
      end


      context 'the current user is not the user being updated' do
        it 'does not update the user'
        it 'redirects'
      end
    end
  end

  # ----------------------------------------
  # DELETE destroy
  # ----------------------------------------

  describe 'DELETE #destroy' do
    context 'the user is not logged in' do
      it 'redirects'
      it 'does not destroy the user'
    end


    context 'the user is logged in' do

      context 'the current user is the user being destroyed' do
        it 'destroys the user'
      end


      context 'the current user is not the user being destroyed' do
        it 'redirects'
        it 'does not destroy the user'
      end
    end
  end
end

