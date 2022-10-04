# supzambot
support zammad bot  
  
1. docker: docker push evonic/supzambot  
  
2. configure settings.conf  
  
chmod 700 /home/en/fetchmail/fetchmail.conf;  
chmod 700 /home/en/fetchmail/procmail.conf;  

3. configure zammad 
  add trigger zammad:
1  
  
![image](https://user-images.githubusercontent.com/46780974/193843501-16400722-9fdf-40c1-b933-a361eaab90f4.png)
  
![image](https://user-images.githubusercontent.com/46780974/193843171-6b0747bf-0753-42f5-8941-e1d26065eff0.png)

2  
  
![image](https://user-images.githubusercontent.com/46780974/193843663-3bcd61c6-9fc9-4727-9001-e1913f5d7296.png)

  subject: #{config.http_type}://#{config.fqdn}/#ticket/zoom/#{ticket.id} #{ticket.number}
![image](https://user-images.githubusercontent.com/46780974/193843777-9413fb3b-81cf-499f-86cf-0ba8febf3630.png)
  
  
4. start docker  
  
  
