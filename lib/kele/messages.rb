module Messages
    
    def get_messages(page)
        response = self.class.get(base_url('message_threads'), body: { page: page}, headers: { authorization: @auth_token })
        @messages = JSON.parse(response.body)
    end


    def create_message(sender, recipient_id, token, subject, message)
        response = self.class.post(base_url('messages'), body: {sender: sender, recipient_id: recipient_id, token: token, subject: subject, stripped_text: message }, headers: { authorization: @auth_token })
        @message = JSON.parse(response.body)
    end
   
end
