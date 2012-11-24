class ChatroomsController < ApplicationController
  # GET /chatrooms
  # GET /chatrooms.json

  

  def index

    @chatrooms = Chatroom.all
    @lat       = params[:lat]
    @long      = params[:long]

    foursquare = Foursquare::Base.new("P5S5WR2SPYHNT1BUVBITZUIKNKNW3CNTM1W1UXDTFV3BURCF", "FQNPNVCTEPE04OQMVMJP152EYUAUXRMDKA1WMLJSEH550VFZ")
    @venues = foursquare.venues.search(:ll => "#{@lat},#{@long}")["nearby"]

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @chatrooms }
    end
  end

  # GET /chatrooms/1
  # GET /chatrooms/1.json
  def show
    @chatroom = Chatroom.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @chatroom }
    end
  end

  # GET /chatrooms/new
  # GET /chatrooms/new.json
  def new
    @chatroom = Chatroom.new
    @venue_id = params[:venue_id]
    foursquare = Foursquare::Base.new("P5S5WR2SPYHNT1BUVBITZUIKNKNW3CNTM1W1UXDTFV3BURCF", "FQNPNVCTEPE04OQMVMJP152EYUAUXRMDKA1WMLJSEH550VFZ")
    @name     = foursquare.venues.find(@venue_id)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @chatroom }
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
