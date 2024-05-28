variable "inbound-rules" {
    type = list
    default =  [ 
        {
        from_port = 22
        to_port = 22
        cidr_blocks = ["0.0.0.0/0"]
        protocol = "tcp"
        },

        {
        from_port = 80
        to_port = 80
        cidr_blocks = ["0.0.0.0/0"]
        protocol = "tcp"
        },

        {
        from_port = 8080
        to_port = 8080
        cidr_blocks = ["0.0.0.0/0"]
        protocol = "tcp"
        },

        {
        from_port = 3306
        to_port = 3306
        cidr_blocks = ["0.0.0.0/0"]
        protocol = "tcp"
        } 
        
        ]
  
}