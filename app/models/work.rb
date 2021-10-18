require 'google/cloud/datastore'

class Work
    @KIND_NAME = "Works"

    def self.all
        @datastore = Google::Cloud::Datastore.new(
            project_id: Rails.application.config.database_configuration[Rails.env]["project_id"],
        )

        query = @datastore.query(@KIND_NAME)
        @datastore.run(query, namespace: Rails.application.config.database_configuration[Rails.env]["namespace"])
    end

    def self.create(params)
        language = @datastore.entity @KIND_NAME, namespace: Rails.application.config.database_configuration[Rails.env]["namespace"] do |t|
            t["name"] = params[:name]
            t["imageUrl"] = params[:imageUrl]
            t["productionTime"] = params[:productionTime]
            t["info"] = params[:info]
            t["url"] = params[:url]
        end
        @datastore.save language
    end
end
