require 'google/cloud/datastore'

class Skills::Base
    @KIND_NAME = :null
    @@datastore = Google::Cloud::Datastore.new(
        project_id: Rails.application.config.database_configuration[Rails.env]["project_id"],
    )

    def self.all
        # lan = [
        #     {
        #         "name": "PostgreSQL",
        #         "level": "中級（1年）",
        #         "levelType": "intermediate",
        #         "detail": "個人開発で使用。"
        #     },
        #     {
        #         "name": "Datastore",
        #         "level": "中級（2年）",
        #         "levelType": "intermediate",
        #         "detail": "通常使用に問題なし。"
        #     },
        #     {
        #         "name": "Firestore",
        #         "level": "中級（4ヶ月）",
        #         "levelType": "intermediate",
        #         "detail": "通常使用に問題なし。"
        #     }
        # ]
        
        # for p in lan do
        #     self.create(p)
        # end

        query = @@datastore.query(@KIND_NAME)
        @@datastore.run(query, namespace: Rails.application.config.database_configuration[Rails.env]["namespace"])
    end

    def self.create(params)
        language = @@datastore.entity @KIND_NAME, namespace: Rails.application.config.database_configuration[Rails.env]["namespace"] do |t|
            t["name"] = params[:name]
            t["level"] = params[:level]
            t["levelType"] = params[:levelType]
            t["detail"] = params[:detail]
        end
        @@datastore.save language
    end
end
