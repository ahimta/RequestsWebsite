shared_examples_for 'index' do |model|
	before do
		@symbol = model.to_s.downcase.pluralize.to_sym
		factory = model.to_s.downcase.to_sym
		@double = FactoryGirl.build_stubbed_list factory, 3
		model.stub(:all).and_return @double
	end
	
	it 'should call Model.all' do
		model.should_receive(:all).with(no_args).and_return @double
		get :index
	end
	
	before { get :index }	
	it { response.should render_template :index }
	it { assigns(@symbol).should == @double }
end

shared_examples_for 'show' do |model|
	before do
		@symbol = model.to_s.downcase.to_sym
		@double = FactoryGirl.build_stubbed @symbol
		model.stub(:find).and_return @double
	end
	
	it 'should call Model.find' do
		model.should_receive(:find).with('0')
		get :show, id: 0
	end
	
	before { get :show, id: 0 }
	
	it { assigns(@symbol).should == @double }
	it { response.should render_template :show }
end

shared_examples_for 'new' do |model|
	before do
		@symbol = model.to_s.downcase.to_sym
		@double = FactoryGirl.build_stubbed @symbol
		
		model.stub(:new).and_return @double
		get :new
	end
	
	it 'should call Model.new' do
		model.should_receive(:new).and_return @double
		get :new
	end
	
	before { get :new }
	
	it { response.should render_template :new }
	it { assigns(@symbol).should == @double }
end

shared_examples_for 'create' do |model, index = '/requests?locale=en'|
	before do
		@symbol = model.to_s.downcase.to_sym
		@double = FactoryGirl.build_stubbed @symbol
		@param = 'x'
		model.stub(:new).and_return @double
		@double.stub(:save)
	end
	after { post :create, @symbol => @param }
	
	it { model.should_receive(:new).with(@param).and_return @double }
	it { @double.should_receive :save }
	it 'should assign @record' do
		post :create, @symbol => @param
		assigns(@symbol).should == @double
	end
	
	context 'fields filled in appropriately' do
		before do
			@double.stub(:save).and_return true
			post :create, @symbol => @param
		end
		
		it { response.should redirect_to index }
		it { flash[:notice].should_not == nil }
	end
	
	context 'fields filled in inappropriately' do
		before do
			double.stub(:save).and_return false
			post :create, @symbol => @param
		end
		
		it { response.should render_template :new }
		it { flash[:warning].should_not == nil }
	end
end

shared_examples_for 'edit' do |model|
	before do
		@symbol = model.to_s.downcase.to_sym
		@double = FactoryGirl.build_stubbed @symbol
		model.stub(:find).and_return @double
	end
	
	it 'should call Model.find' do
		model.should_receive(:find).with(0.to_s)
		get :edit, id: 0
	end
	
	before { get :edit, id: 0 }
	
	it { assigns(@symbol).should == @double }
	it { response.should render_template :edit }
end

shared_examples_for 'update' do |model, index = '/requests?locale=en'|
	before do
		@symbol = model.to_s.downcase.to_sym
		@double = FactoryGirl.build_stubbed @symbol
		model.stub(:find).and_return @double
		@double.stub(:attributes=).and_return @double
		@double.stub(:save)
	end
	after { put :update, @symbol => 'record', id: 0 }
	
	it { model.should_receive(:find).with('0') }
	it { @double.should_receive(:save).with(no_args) }
	it { @double.should_receive(:attributes=).with('record') }
	it 'should assign @record' do
		put :update, @symbol => 'record', id: 0
		assigns(@symbol).should == @double
	end
	
	context 'fields filled in appropriately' do
		before do
			@double.stub(:save).and_return true
			put :update, @symbol => 'record', id: 0
		end
		
		it { response.should redirect_to index }
	end
	
	context 'fields filled in inappropriately' do
		before do
			double.stub(:save).and_return false
			put :update, @symbol => 'record', id: 0
		end
		
		it { response.should render_template :edit }
	end
end

shared_examples_for 'destroy' do |model, index = '/requests?locale=en'|
	before do
		@symbol = model.to_s.downcase.to_sym
		@double = FactoryGirl.build_stubbed @symbol
		model.stub(:find).and_return @double
		@double.stub(:destroy)
	end
	after { delete :destroy, id: 0 }
	
	it { model.should_receive(:find).with('0') }
	it { @double.should_receive(:destroy).with(no_args) }
	
	before { delete :destroy, id: 0 }
	
	it { assigns(@symbol).should == @double }
	it { response.should redirect_to index }
end
