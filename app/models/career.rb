require 'google/cloud/datastore'
require "google/cloud/storage"

class Career
    @KIND_NAME = "Careers"
    @@datastore = Google::Cloud::Datastore.new(
        project_id: Rails.application.config.database_configuration[Rails.env]["project_id"],
    )
    @@storage = Google::Cloud::Storage.new(
        project_id: Rails.application.config.database_configuration[Rails.env]["project_id"],
    )

    def self.all
        query = @@datastore.query(@KIND_NAME).order("index")
        result = @@datastore.run(query, namespace: Rails.application.config.database_configuration[Rails.env]["namespace"])

        result.each.with_index do |career, index|
            if index + 1 == result.length then
                career['firstLine'] = '└'
                career['secondLine'] = ' '
            else
                career['firstLine'] = '├'
                career['secondLine'] = '│'
            end
        end

        result
    end

    def self.create(params)
        language = @@datastore.entity @KIND_NAME, namespace: Rails.application.config.database_configuration[Rails.env]["namespace"] do |t|
            t["index"] = params[:index]
            t["title"] = params[:title]
            t["duration"] = params[:duration]
            t["info"] = params[:info]
        end
        @@datastore.save language
    end
end
