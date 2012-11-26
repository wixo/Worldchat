class ChatroomsController < ApplicationController
  # GET /chatrooms
  # GET /chatrooms.json

  

  def index

    @chatrooms = Chatroom.all
    @lat       = params[:lat]
    @long      = params[:long]
    # browser = Browser.new(:ua => request.env['HTTP_USER_AGENT'], :accept_language => "en-us")
    # # @ua = request.env['HTTP_USER_AGENT']
    # @ua = browser.name

    foursquare = Foursquare::Base.new("P5S5WR2SPYHNT1BUVBITZUIKNKNW3CNTM1W1UXDTFV3BURCF", "FQNPNVCTEPE04OQMVMJP152EYUAUXRMDKA1WMLJSEH550VFZ")

    @venues = foursquare.venues.search(:ll => "#{@lat},#{@long}")["nearby"] unless (@lat.blank? or @long.blank?)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @chatrooms }
    end
  end

  # GET /chatrooms/1
  # GET /chatrooms/1.json
  def show
    @chatroom = Chatroom.find(params[:id])
    @messages = Message.where("chatroom_id = ?", params[:id]).order("created_at desc").limit(20)
    @message  = Message.new

    ua = request.env['HTTP_USER_AGENT']
    
    browser    = Browser.new(:ua => ua)
    @ua        = browser.meta

    if cookies[:worldchat_login].present?
        @user_name = cookies[:worldchat_login]
        @user = User.find_by_name(@user_name)
    else
        @user_name = "#{@ua[2]}-#{@ua[0]}-#{User.last.id+1}"     
        @user = User.create(:name => @user_name,
                            :venue_id => 1,
                            :foursquare_id => 1
                            )
        cookies[:worldchat_login] = { value: @user_name }
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @chatroom }
    end
  end

  # GET /chatrooms/new
  # GET /chatrooms/new.json
  def new
    @chatroom  = Chatroom.new
    @venue_id  = params[:venue_id]
    foursquare = Foursquare::Base.new("P5S5WR2SPYHNT1BUVBITZUIKNKNW3CNTM1W1UXDTFV3BURCF", "FQNPNVCTEPE04OQMVMJP152EYUAUXRMDKA1WMLJSEH550VFZ")
    @name      = foursquare.venues.find(@venue_id)

    # chatroom_exists = Chatroom.find_by_venue_id(@venue_id).blank?

    # logger.debug "CHATROOM EXISTS"
    # logger.debug chatroom_exists
    # logger.debug Chatroom.find_by_venue_id(@venue_id).blank?
    # logger.debug @venue_id

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @chatroom }
    end
  end

  # GET /chatrooms/join/<venue_id>
  def join
    @venue_id = params[:venue_id]
    chatroom_exists = Chatroom.find_by_venue_id(@venue_id).present?

    if chatroom_exists
      render "show"
    else
      foursquare = Foursquare::Base.new("P5S5WR2SPYHNT1BUVBITZUIKNKNW3CNTM1W1UXDTFV3BURCF", "FQNPNVCTEPE04OQMVMJP152EYUAUXRMDKA1WMLJSEH550VFZ")
      @name      = foursquare.venues.find(@venue_id).name
      @chatroom  = Chatroom.create(:venue_id => @venue_id, 
                                       :name => @name,
                                       :is_available => true
      )

      @messages = nil
      @message  = Message.new

      respond_to do |format|
        if @chatroom.save
          format.html { redirect_to @chatroom, notice: 'Chatroom was successfully created.' }
          format.json { render json: @chatroom, status: :created, location: @chatroom }
        else
          format.html { render action: "new" }
          format.json { render json: @chatroom.errors, status: :unprocessable_entity }
        end
      end
    end

  end

  # GET /chatrooms/1/edit
  def edit
    @chatroom = Chatroom.find(params[:id])
  end

  # POST /chatrooms
  # POST /chatrooms.json
  def create
    @chatroom = Chatroom.new(params[:chatroom])

    respond_to do |format|
      if @chatroom.save
        format.html { redirect_to @chatroom, notice: 'Chatroom was successfully created.' }
        format.json { render json: @chatroom, status: :created, location: @chatroom }
      else
        format.html { render action: "new" }
        format.json { render json: @chatroom.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /chatrooms/1
  # PUT /chatrooms/1.json
  def update
    @chatroom = Chatroom.find(params[:id])

    respond_to do |format|
      if @chatroom.update_attributes(params[:chatroom])
        format.html { redirect_to @chatroom, notice: 'Chatroom was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @chatroom.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chatrooms/1
  # DELETE /chatrooms/1.json
  def destroy
    @chatroom = Chatroom.find(params[:id])
    @chatroom.destroy

    respond_to do |format|
      format.html { redirect_to chatrooms_url }
      format.json { head :no_content }
    end
  end
end
