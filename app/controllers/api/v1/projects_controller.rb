class Api::V1::ProjectsController < ApplicationController

  def create
    new_project = Project.create(project_params)
    if new_project.save
      render json: ProjectSerializer.new(new_project), status: 200
    else
      render json: { error: new_project.errors, status: "400 Bad Request" }, status: 400
    end
  end

private

  def project_params
    params.require(:project).permit(:projectName,
                                    :projectPet,
                                    :petHealth,
                                    :petLevel,
                                    :projectGitHub,
                                    :petImage,
                                    :user_id,
                                    :stats => [:totalWorkTime,
                                               :totalWorkSessions,
                                               :totalShortPomTime,
                                               :totalShortSessions,
                                               :totalLongPomTime,
                                               :totalLongSessions])
  end

end
