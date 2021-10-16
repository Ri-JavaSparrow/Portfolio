require 'google/cloud/datastore'

class Framework
    @KIND_NAME = "Frameworks"
    
    def self.all
        @datastore = Google::Cloud::Datastore.new(
            project_id: Rails.application.config.database_configuration[Rails.env]["dataset_id"]
        )

        # lan = [
        #     {
        #         "name": "Xamarin.Forms",
        #         "level": "上級（2年）",
        #         "levelType": "advanced",
        #         "detail": "指導可能。"
        #     },
        #     {
        #         "name": "Xamarin.Mac",
        #         "level": "初級（3ヶ月）",
        #         "levelType": "beginner",
        #         "detail": "個人開発で使用。"
        #     },
        #     {
        #         "name": "Django",
        #         "level": "中級（2年）",
        #         "levelType": "intermediate",
        #         "detail": "通常使用に問題なし。"
        #     },
        #     {
        #         "name": "Flask",
        #         "level": "中級（2年）",
        #         "levelType": "intermediate",
        #         "detail": "通常使用に問題なし。"
        #     },
        #     {
        #         "name": "Vue.js",
        #         "level": "中級（4ヶ月）",
        #         "levelType": "intermediate",
        #         "detail": "通常使用に問題なし。"
        #     },
        #     {
        #         "name": "React",
        #         "level": "初級（4ヶ月）",
        #         "levelType": "beginner",
        #         "detail": "調べながらであれば。"
        #     },
        #     {
        #         "name": "Flutter",
        #         "level": "初級（1年）",
        #         "levelType": "beginner",
        #         "detail": "個人開発で使用。"
        #     },
        #     {
        #         "name": "Ruby on Rails",
        #         "level": "初級（1ヶ月）",
        #         "levelType": "beginner",
        #         "detail": "個人開発で使用。"
        #     }
        # ]
        
        # for p in lan do
        #     self.create(p)
        # end

        query = @datastore.query(@KIND_NAME)
        @datastore.run(query, namespace: Rails.application.config.database_configuration[Rails.env]["namespace"])
    end

    def self.create(params)
        framework = @datastore.entity @KIND_NAME, namespace: Rails.application.config.database_configuration[Rails.env]["namespace"] do |t|
            t["name"] = params[:name]
            t["level"] = params[:level]
            t["levelType"] = params[:levelType]
            t["detail"] = params[:detail]
        end
        @datastore.save framework
    end
end
