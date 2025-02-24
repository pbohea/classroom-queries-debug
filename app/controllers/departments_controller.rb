class DepartmentsController < ApplicationController
  def index
    matching_departments = Department.all
    
    @departments = matching_departments.order({ :created_at => :desc })

    render({ :template => "departments/index" })
  end

  def show
    the_id = params.fetch("path_id")
    matching_dept = Department.where({ :id => the_id })
    @department = matching_dept.at(0)


    render({ :template => "departments/show" })
  end

  def create
    @department = Department.new
    @department.name = params.fetch("query_name")

    if @department.valid?
      @department.save
      redirect_to("/departments", { :notice => "Department created successfully." })
    else
      redirect_to("/departments", { :notice => "Department failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    matching_dept = Department.where({ :id => the_id })
    @department = matching_dept.at(0)

    @department.name = params.fetch("query_name")

    if @department.valid?
      @department.save
      redirect_to("/departments/#{@department.id}", { :notice => "Department updated successfully."} )
    else
      redirect_to("/departments/#{@department.id}", { :alert => "Department failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    matching_dept = Department.where({ :id => the_id })
    @department = matching_dept.at(0)
    @department.destroy

    redirect_to("/departments", { :notice => "Department deleted successfully."} )
  end
end
