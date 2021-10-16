require 'google/cloud/datastore'

languages = [
    {
    "name": "C#",
    "level": "advanced",
    "detail": "test"
    }
]

class Language
    def self.all
        datastore = Google::Cloud::Datastore.new(
            project: Rails.application.config.database_configuration[Rails.env]["dataset_id"]
        )
        query = datastore.query("Language")
        datastore.run(query)
    end
end
