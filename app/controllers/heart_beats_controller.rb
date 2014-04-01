class HeartBeatsController < ApplicationController
  before_action :set_heart_beat, only: [:show, :edit, :update, :destroy]

  # GET /heart_beats
  # GET /heart_beats.json
  def index
    @heart_beats = HeartBeat.all
  end

  # GET /heart_beats/1
  # GET /heart_beats/1.json
  def show
  end

  # GET /heart_beats/new
  def new
    raise "How can we have a hear beat withtout a person ?" if Person.count == 0
    @heart_beat = HeartBeat.new
    @heart_beat.person = Person.first 
  end

  # GET /heart_beats/1/edit
  def edit
  end

  # POST /heart_beats
  # POST /heart_beats.json
  def create
    heart_beat= DateTime.new(params["heart_beat"]["heart_beat(1i)"].to_i,
                             params["heart_beat"]["heart_beat(2i)"].to_i,
                             params["heart_beat"]["heart_beat(3i)"].to_i,
                             params["heart_beat"]["heart_beat(4i)"].to_i,
                             params["heart_beat"]["heart_beat(5i)"].to_i)
    @heart_beat = HeartBeat.new({heart_beat: heart_beat, intensity:  params["heart_beat"]["intensity"].to_i})
    @heart_beat.person = Person.first

    respond_to do |format|
      if @heart_beat.save
        format.html { redirect_to @heart_beat, notice: 'Heart beat was successfully created.' }
        format.json { render action: 'show', status: :created, location: @heart_beat }
      else
        format.html { render action: 'new' }
        format.json { render json: @heart_beat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /heart_beats/1
  # PATCH/PUT /heart_beats/1.json
  def update
    respond_to do |format|
      if @heart_beat.update(heart_beat_params)
        format.html { redirect_to @heart_beat, notice: 'Heart beat was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @heart_beat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /heart_beats/1
  # DELETE /heart_beats/1.json
  def destroy
    @heart_beat.destroy
    respond_to do |format|
      format.html { redirect_to heart_beats_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_heart_beat
      @heart_beat = HeartBeat[Person.first.id.to_s].find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def heart_beat_params
      params.require(:heart_beat).permit(:heart_beat, :intensity)
    end
end
