require 'google/cloud/datastore'

frameworks = [
    {
    "name": "Xamarin.Forms",
    "level": "advanced",
    "detail": "test"
    }
]

class Framework
    def self.all
        datastore = Google::Cloud::Datastore.new(
            project: Rails.application.config.database_configuration[Rails.env]["dataset_id"]
        )
        query = datastore.query("Framework")
        datastore.run(query)
    end
end
