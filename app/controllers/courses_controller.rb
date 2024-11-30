class CoursesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_course, only: %i[ show edit update destroy ]
  
  # GET /courses or /courses.json
  def index
    @courses = Course.all
  end

  # GET /courses/1 or /courses/1.json
  def show
  end

  # GET /courses/new
  def new
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses or /courses.json
  def create
    @course = current_user.courses.build(course_params)
    if @course.save
      redirect_to @course, notice: 'Course created successfully!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /courses/1 or /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: "Course was successfully updated." }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1 or /courses/1.json
  def destroy
    @course.destroy

    respond_to do |format|
      format.html { redirect_to courses_path, status: :see_other, notice: "Course was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def subscribe
    course = Course.find(params[:id])
    if current_user.subscribed_courses << course
      redirect_to courses_path, notice: "You have subscribed to #{course.title}."
    else
      redirect_to courses_path, alert: "Subscription failed."
    end
  end

  def unsubscribe
    course = Course.find(params[:id])
    if current_user.subscribed_courses.destroy(course)
      redirect_to courses_path, notice: "You have unsubscribed from #{course.title}."
    else
      redirect_to courses_path, alert: "Unsubscription failed."
    end
  end
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def course_params
      params.require(:course).permit(:title, :description, :price)
    end
end
