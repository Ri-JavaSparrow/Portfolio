require 'google/cloud/datastore'

class User
    @KIND_NAME = "Users"
    @@datastore = Google::Cloud::Datastore.new(
        project_id: Rails.application.config.database_configuration[Rails.env]["project_id"],
    )

    def self.get
        uid = 6203775702269952
        key = @@datastore.key @KIND_NAME, uid, namespace: Rails.application.config.database_configuration[Rails.env]["namespace"]
        @@datastore.find key
    end

    def self.create(params)
        language = @@datastore.entity @KIND_NAME, namespace: Rails.application.config.database_configuration[Rails.env]["namespace"] do |t|
            t["realName"] = params[:realName]
            t["handleName"] = params[:handleName]
            t["birthday"] = params[:birthday]
            t["area"] = params[:area]
            t["likes"] = params[:likes]
            t["profile"] = params[:profile]
        end
        @@datastore.save language
    end
end
