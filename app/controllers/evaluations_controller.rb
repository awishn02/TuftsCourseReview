class EvaluationsController < ApplicationController
  before_action :set_evaluation, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction
  require 'will_paginate/array'

  # GET /evaluations
  # GET /evaluations.json
  def index
    if params[:main_column] == "Professor"
      @evaluations = Evaluation.select("AVG(evaluations.course_score) as average_course_score,"+
                                       "AVG(evaluations.teacher_score) as average_teacher_score,"+
                                       "evaluations.professor_id AS professor_id,"+
                                       "professors.name")
                               .group(['professor_id','professors.name'])
                               .search(params[:search])
                               .joins(:course,:semester,:professor)
                               .order(sort_column_prof + ' ' + sort_direction)
                               .paginate(:per_page => 20, :page => params[:page])
    else
      @evaluations = Evaluation.select("AVG(evaluations.course_score) as average_course_score,"+
                                     "AVG(evaluations.teacher_score) as average_teacher_score,"+
                                     "evaluations.course_id AS course_id, courses.course_num AS "+
                                     "course_num, courses.name")
                             .group(['course_id','course_num','courses.name'])
                             .search(params[:search])
                             .joins(:course,:semester,:professor)
                             .order(sort_column + ' ' + sort_direction)
                             .paginate(:per_page => 20, :page => params[:page])
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
      Evaluation.column_names.include?(params[:sort]) || %w[courses.name professors.name course_num semesters.name average_course_score average_teacher_score].include?(params[:sort]) ? params[:sort] : "course_num"
    end

    def sort_column_prof
      Evaluation.column_names.include?(params[:sort]) || %w[courses.name professors.name course_num semesters.name average_course_score average_teacher_score].include?(params[:sort]) ? params[:sort] : "professors.name"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
