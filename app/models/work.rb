require 'google/cloud/datastore'
require "google/cloud/storage"

class Work
    @KIND_NAME = "Works"
    @@datastore = Google::Cloud::Datastore.new(
        project_id: Rails.application.config.database_configuration[Rails.env]["project_id"],
    )
    @@storage = Google::Cloud::Storage.new(
        project_id: Rails.application.config.database_configuration[Rails.env]["project_id"],
    )

    def self.all
        query = @@datastore.query(@KIND_NAME)
        result = @@datastore.run(query, namespace: Rails.application.config.database_configuration[Rails.env]["namespace"])

        bucket = @@storage.bucket "portfolio-resource"
        result.each do |work|
            file = bucket.file work["imageUrl"]
            work["imageSrc"] = file.signed_url
        end
        result
    end

    def self.create(params)
        language = @@datastore.entity @KIND_NAME, namespace: Rails.application.config.database_configuration[Rails.env]["namespace"] do |t|
            t["name"] = params[:name]
            t["imageUrl"] = params[:imageUrl]
            t["productionTime"] = params[:productionTime]
            t["info"] = params[:info]
            t["url"] = params[:url]
        end
        @@datastore.save language
    end
end
