class WordStatsController < ApplicationController
  before_action :set_word_stat, only: [:show, :edit, :update, :destroy]

  # GET /word_stats
  # GET /word_stats.json
  def index
    @word_stats = WordStat.all
  end

  # GET /word_stats/1
  # GET /word_stats/1.json
  def show
  end

  # GET /word_stats/new
  def new
    @word_stat = WordStat.new
  end

  # GET /word_stats/1/edit
  def edit
  end

  # POST /word_stats
  # POST /word_stats.json
  def create
    @word_stat = WordStat.new(word_stat_params)

    respond_to do |format|
      if @word_stat.save
        format.html { redirect_to @word_stat, notice: 'Word stat was successfully created.' }
        format.json { render :show, status: :created, location: @word_stat }
      else
        format.html { render :new }
        format.json { render json: @word_stat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /word_stats/1
  # PATCH/PUT /word_stats/1.json
  def update
    respond_to do |format|
      if @word_stat.update(word_stat_params)
        format.html { redirect_to @word_stat, notice: 'Word stat was successfully updated.' }
        format.json { render :show, status: :ok, location: @word_stat }
      else
        format.html { render :edit }
        format.json { render json: @word_stat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /word_stats/1
  # DELETE /word_stats/1.json
  def destroy
    @word_stat.destroy
    respond_to do |format|
      format.html { redirect_to word_stats_url, notice: 'Word stat was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_word_stat
      @word_stat = WordStat.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def word_stat_params
      params.require(:word_stat).permit(:name, :one_month_frequency, :one_week_frequency, :one_day_frequency, :half_day_frequency, :quarter_day_frequency, :one_hour_frequency)
    end
end
