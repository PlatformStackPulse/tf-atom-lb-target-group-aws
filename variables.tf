variable "port" {
  description = "Port the target receives traffic on"
  type        = number
  default     = 80
}

variable "protocol" {
  description = "Protocol (HTTP, HTTPS, TCP, TLS, UDP, TCP_UDP)"
  type        = string
  default     = "HTTP"
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
  validation {
    condition     = length(var.vpc_id) > 0
    error_message = "vpc_id must not be empty."
  }
}

variable "target_type" {
  description = "Target type (instance, ip, lambda, alb)"
  type        = string
  default     = "instance"
  validation {
    condition     = contains(["instance", "ip", "lambda", "alb"], var.target_type)
    error_message = "target_type must be instance, ip, lambda, or alb."
  }
}

variable "deregistration_delay" {
  description = "Deregistration delay in seconds"
  type        = number
  default     = 300
}

variable "health_check_path" {
  description = "Health check path"
  type        = string
  default     = "/"
}

variable "health_check_port" {
  description = "Health check port"
  type        = string
  default     = "traffic-port"
}

variable "health_check_protocol" {
  description = "Health check protocol"
  type        = string
  default     = "HTTP"
}

variable "healthy_threshold" {
  description = "Consecutive successes to mark healthy"
  type        = number
  default     = 3
}

variable "unhealthy_threshold" {
  description = "Consecutive failures to mark unhealthy"
  type        = number
  default     = 3
}

variable "health_check_timeout" {
  description = "Health check timeout in seconds"
  type        = number
  default     = 5
}

variable "health_check_interval" {
  description = "Health check interval in seconds"
  type        = number
  default     = 30
}

variable "health_check_matcher" {
  description = "HTTP status codes for healthy response"
  type        = string
  default     = "200"
}
