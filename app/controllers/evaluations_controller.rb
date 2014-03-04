class EvaluationsController < ApplicationController
  before_action :set_evaluation, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction
  require 'will_paginate/array'

  # GET /evaluations
  # GET /evaluations.json
  def index
    @evaluations = Evaluation.search(params[:search]).all(:include => [:course, :professor], :order => sort_column + ' ' + sort_direction).paginate(:per_page => 20, :page => params[:page])
    # @evaluation_scores = Array.new(10000) { Array.new(10000)}
    # @evaluations.each do |eval|
    #   @evaluation_scores[eval.course_id][eval.professor_id] = {
    #                                                             "course_name" => eval.course.name,
    #                                                             "course_num" => eval.course.course_num,
    #                                                             "professor_name" => eval.professor.name,
    #                                                             "course_score" => eval.course.get_score_for_professor(eval.professor_id),
    #                                                             "teacher_score" => eval.professor.get_score_for_course(eval.course_id)
    #                                                           }
    # end
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
      Evaluation.column_names.include?(params[:sort]) || %w[courses.name professors.name courses.course_num].include?(params[:sort]) ? params[:sort] : "courses.course_num"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
