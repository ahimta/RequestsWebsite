require 'spec_helper'

describe VacationsController do
	let(:vacation) { mock_model Vacation, id: 0, applicant: 'X', duration: 1,
		day: 2, month: 3, year: 4, user_id: 0 }
	let(:param) { { 'vacation' => { 'applicant' => 'X', 'duration' => '1',
		'day' => '2', 'month' => '1', 'year' => '4', 'user_id' => '0' } } }
	
	describe 'new action' do
		before(:each) do
			Vacation.stub(:new).and_return vacation
			get :new
		end
		
		it 'should call Vacation.new' do
			Vacation.should_receive(:new).and_return vacation
			get :new
		end
		it 'should assign @vacation' do
			assigns(:vacation).should == vacation
		end
		it 'should render new' do
			response.should render_template :new
		end
	end
	
	describe 'create action' do
		before(:each) do
			Vacation.stub(:new).and_return vacation
			vacation.stub(:save)
		end
		after(:each) { post :create, vacation: param }
		
		it 'should call Vacation.new' do
			Vacation.should_receive(:new).with(param).and_return vacation
		end
		it 'should call vacation.save' do
			vacation.should_receive :save
		end
		it 'should assign @vacation' do
			post :create, vacation: param
			assigns(:vacation).should == vacation
		end
		
		context 'fields filled in appropriately' do
			before(:each) do
				vacation.stub(:save).and_return true
				post :create, vacation: param
			end
			
			it 'should redirect to vacations_path' do
				response.should redirect_to vacations_path
			end
			it 'should assign flash[:notice]' do
				flash[:notice].should_not == nil
			end
		end
		
		context 'fields filled in inappropriately' do
			before(:each) do
				vacation.stub(:save).and_return false
				post :create, vacation: param
			end
			
			it 'should render new' do
				response.should render_template :new
			end
			it 'should assign flash[:warning]' do
				flash[:warning].should_not == nil
			end
		end
	end
end