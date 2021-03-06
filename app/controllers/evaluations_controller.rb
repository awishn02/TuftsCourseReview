class EvaluationsController < ApplicationController
  before_action :set_evaluation, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction
  require 'will_paginate/array'

  # GET /evaluations
  # GET /evaluations.json
  def index
    if params[:search]
      page = params[:page] ? params[:page] : 1
      if params[:main_column] == "Professor"
        @evaluations = Rails.cache.read(params[:search]+"Professor"+page.to_s)
        if !@evaluations
          @evaluations = ProfessorScore.search(params[:search])
          .order(sort_column_prof + ' ' + sort_direction)
          .paginate(:per_page => 20, :page => params[:page])
          Rails.cache.write(params[:search]+"Professor"+page.to_s, @evaluations)
        end
      else
        @evaluations = Rails.cache.read(params[:search]+"Course"+page.to_s)
        if !@evaluations
          @evaluations = ProfessorScore.search_course(params[:search])
          .order(sort_column + ' ' + sort_direction)
          .paginate(:per_page => 20, :page => params[:page])
          Rails.cache.write(params[:search]+"Course"+page.to_s, @evaluations)
        end
      end
    end
  end

  def ajax
    @id = params[:id]
    @main_column = params[:main_column]
    if @main_column == "Instructor"
      @evals = ProfessorScore.get_course_data(@id)
    else
      @evals = ProfessorScore.get_professor_data(@id)
    end
  end

  # GET /evaluations/1
  # GET /evaluations/1.json
  def show
  end

  # GET /evaluations/new
  def new
    @evaluation = Evaluation.new
  end

  # GET /evaluations/1/edit
  def edit
  end

  # POST /evaluations
  # POST /evaluations.json
  def create
    @evaluation = Evaluation.new(evaluation_params)

    respond_to do |format|
      if @evaluation.save
        format.html { redirect_to @evaluation, notice: 'Evaluation was successfully created.' }
        format.json { render action: 'show', status: :created, location: @evaluation }
      else
        format.html { render action: 'new' }
        format.json { render json: @evaluation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /evaluations/1
  # PATCH/PUT /evaluations/1.json
  def update
    respond_to do |format|
      if @evaluation.update(evaluation_params)
        format.html { redirect_to @evaluation, notice: 'Evaluation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @evaluation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /evaluations/1
  # DELETE /evaluations/1.json
  def destroy
    @evaluation.destroy
    respond_to do |format|
      format.html { redirect_to evaluations_url }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_evaluation
    @evaluation = Evaluation.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def evaluation_params
    params.require(:evaluation).permit(:course_id, :professor_id, :course_score, :teacher_score)
  end

  def sort_column
    Evaluation.column_names.include?(params[:sort]) || %w[courses.name professors.utln course_num semesters.name average_course_score average_professor_score].include?(params[:sort]) ? params[:sort] : "course_num"
  end

  def sort_column_prof
    Evaluation.column_names.include?(params[:sort]) || %w[courses.name professors.utln course_num semesters.name average_course_score average_professor_score].include?(params[:sort]) ? params[:sort] : "professors.utln"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
