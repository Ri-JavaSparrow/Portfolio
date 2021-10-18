module PortfolioHelper
    def navigations
        [
            {
                'id': 'profile-menu', 
                'name': 'Profile', 
                'link': '#profile', 
                'class': 'disable'
            },
            {
                'id': 'skills-menu', 
                'name': 'Skills', 
                'link': '#skills', 
                'class': 'disable'
            },
            {
                'id': 'works-menu', 
                'name': 'Works', 
                'link': '#works', 
                'class': 'disable'
            },
            {
                'id': 'contact-menu', 
                'name': 'Contact', 
                'link': '#contact', 
                'class': 'disable'
            }
        ]
    end
end
