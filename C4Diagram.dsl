workspace "Pawfect Care Model" "C4 Architecture Model Of Pawfect Care"{

    !identifiers hierarchical

    model {
        user_1 = person "Clients" "Pet Owners interested in the well being of his pet" "Usuario"
        user_2 = person "Veterinarians" "Users specialized in veterinary medicine" "veterinario"
        external_s1 = softwareSystem "Google OAuth2" "Gmail API for authentication" {
            tags "External System"
        }
        external_s2 = softwareSystem "AI Agent" "Chat consultation service through an integrated chatbot" {
            tags "External System"
        }
        ss = softwareSystem "Pawfect Care" "Manages appointments, connects veterinarians, and provides access to a pet's medical history." {
            //Landing Page
            lp = container "Landing Page" "Website that provides a first contact and benefits of the business" "HTML & CSS" "WebPage"
            //Web Application
            wa = container "Web Application" "Frontend" "HTML, TS, CSS, Angular" "WebPage"
            //Api Gateway
            api = container "Gateway Service" "Provides a simple yet powerful way to route to APIs" "Spring Cloud Gateway" {
                tags "Gateway"
            }
            //Eureka Server
            registry_service = container "Registry Service" "Service registry for microservice discovery" "Netflix Eureka, Spring Cloud" {
                tags "MS"
            }
            //MS: Account Service
            account_service = container "Account Service" "Manages user authentication and registration" "Spring Boot + JWT" {
                tags "MS"
                authentication_controller             = component "AuthenticationController"               "Handles sign in and sign up requests"                     "Spring Boot"
                google_authentication_controller      = component "GoogleAuthenticationController"        "Handles OAuth2 sign in with Google"                       "Spring Boot"
                roles_controller                      = component "RolesController"                       "Manages role creation and lookup"                         "Spring Boot"
                users_admin_controller                = component "UsersAdminController"                  "Manages administrative user accounts"                     "Spring Boot"
                role_command_service_impl             = component "RoleCommandServiceImpl"                 "Implements RoleCommandService"                          "Spring Boot"
                user_admin_command_service_impl       = component "UserAdminCommandServiceImpl"            "Implements UserAdminCommandService"                    "Spring Boot"
                role_query_service_impl               = component "RoleQueryServiceImpl"                   "Implements RoleQueryService"                           "Spring Boot"
                user_admin_query_service_impl         = component "UserAdminQueryServiceImpl"              "Implements UserAdminQueryService"                      "Spring Boot"
                application_ready_event_handler       = component "ApplicationReadyEventHandler"           "Initializes default roles on startup"                  "Spring Boot"
                role_command_service                  = component "RoleCommandService"                     "Defines role command operations"                     "Spring Boot"
                user_admin_command_service            = component "UserAdminCommandService"                "Defines user admin command operations"               "Spring Boot"
                role_query_service                    = component "RoleQueryService"                       "Defines role query operations"                       "Spring Boot"
                user_admin_query_service              = component "UserAdminQueryService"                  "Defines user admin query operations"                 "Spring Boot"
                security_config                       = component "SecurityConfig"                         "Configures authentication/authorization rules"             "Spring Security Configuration"
                bcrypt_password_encoder               = component "BCryptPasswordEncoder"                  "Hashes and verifies user passwords"                    "Spring Boot"
                google_oauth_client                   = component "GoogleOAuthClient"                      "Handles Google OAuth2 flows"                           "Spring Boot"
                jwt_provider                          = component "JwtProvider"                            "Generates and validates JWT tokens"                    "Spring Boot"
                role_repository                       = component "RoleRepository"                         "Persists and retrieves Role entities"                  "Spring Boot" 
                user_admin_repository                 = component "UserAdminRepository"                     "Persists and retrieves UserAdmin entities"            "Spring Boot"  
            }
            account_db = container "Account DB" "PostgreSQL database for account service" "PostgreSQL" {
                tags "Database"
            }
            //MS: Veterinary Service
            veterinary_service = container "Veterinary Service" "Handles veterinarian profiles and availability" "Spring Boot" {
                tags "MS"
                veterinarians_controller = component "Veterinans Controller" "REST controller for veterinarians" "Spring Boot"
                
                veterinarian_command_service_impl = component "Veterinarian CommandService Impl" "Implements VeterinarianCommandService" "Spring Boot"
                veterinarian_query_service_impl = component "Veterinarian Query Service Impl" "Implements VeterinarianQueryService" "Spring Boot"
                
                veterinarian_command_service = component "VeterinarianCommandService" "Defines command operations" "Spring Boot"
                veterinarian_query_service = component "VeterinarianQueryService" "Defines query operations" "Spring Boot"
                
                veterinarian_repository = component "Veterinarian Repository" "Persists and retrieves Veterinarian entities" "Spring Boot"
                
                resource_assembler = component "VeterinarianResourceFromEntityAssembler" "Converts Entity → DTO" "Spring Boot"
                create_assembler = component "CreateVeterinarianCommandFromResourceAssembler" "Converts DTO → CreateCommand" "Spring Boot"
                update_assembler = component "UpdateVeterinarianCommandFromResourceAssembler" "Converts DTO → UpdateCommand" "Spring Boot"
                availability_assembler = component "UpdateVeterinarianAvailabilityCommandFromResourceAssembler" "Converts DTO → UpdateAvailabilityCommand" "Spring Boot"
                
            }
            veterinary_db = container "Veterinary DB" "PostgreSQL database for veterinary service" "PostgreSQL" {
                tags "Database"
            }
            //MS: Schedule Service
            schedule_service = container "Schedule Service" "Tracks veterinarian schedules and availability slots" "Spring Boot" {
                tags "MS"
                schedule_controller = component "ScheduleController" "REST controller for schedules" "Spring Boot"
                vet_schedule_controller = component "VeterinarianScheduleController" "REST controller for veterinarian-specific schedules" "Spring Boot"
            
                schedule_command_service_impl = component "ScheduleCommandServiceImpl" "Implements ScheduleCommandService" "Spring Boot"
                schedule_query_service_impl = component "ScheduleQueryServiceImpl" "Implements ScheduleQueryService" "Spring Boot"
                external_veterinarian = component "ExternalVeterinarian" "Adapter for Veterinary Service availability" "Spring Boot"
            
                schedule_command_service = component "ScheduleCommandService" "Defines command operations" "Spring Boot"
                schedule_query_service = component "ScheduleQueryService" "Defines query operations" "Spring Boot"
            
                schedule_repository = component "ScheduleRepository" "Persists and retrieves Schedule entities" "Spring Boot"
            
                resource_assembler = component "ScheduleResourceFromEntityAssembler" "Converts Entity → DTO" "Spring Boot"
                create_assembler = component "CreateScheduleCommandFromResourceAssembler" "Converts DTO → CreateCommand" "Spring Boot"
                update_assembler = component "UpdateScheduleCommandFromResourceAssembler" "Converts DTO → UpdateCommand" "Spring Boot"
            
                rest_template_config = component "RestTemplateConfig" "Configures RestTemplate for external calls" "Spring Boot"
            }
            schedule_db = container "Schedule DB" "PostgreSQL database for schedule service" "PostgreSQL" {
                tags "Database"
            }
            //MS: Pet Owner Service
            pet_owner_service = container "Pet Owner Service" "Manages pet owner profile, details and preferences" "Spring Boot" {
                tags "MS"
                
            pet_owners_controller = component "PetOwnersController" "REST controller for pet owners" "Spring Boot"
            
            pet_owner_command_service_impl = component "PetOwnerCommandServiceImpl" "Implements PetOwnerCommandService" "Spring Boot"
            pet_owner_query_service_impl = component "PetOwnerQueryServiceImpl" "Implements PetOwnerQueryService" "Spring Boot"
            
            pet_owner_command_service = component "PetOwnerCommandService" "Defines command operations" "Spring Boot"
            pet_owner_query_service = component "PetOwnerQueryService" "Defines query operations" "Spring Boot"
            pet_owner_repository = component "PetOwnerRepository" "Persists and retrieves PetOwner entities" "Spring Boot"
            
            resource_assembler = component "PetOwnerResourceFromEntityAssembler" "Converts Entity → DTO" "Spring Boot"
            create_assembler = component "CreatePetOwnerCommandFromResourceAssembler" "Converts DTO → CreateCommand" "Spring Boot"
            update_assembler = component "UpdatePetOwnerCommandFromResourceAssembler" "Converts DTO → UpdateCommand" "Spring Boot"
            }
            pet_owner_db = container "Pet Owner DB" "PostgreSQL database for pet owner service" "PostgreSQL" {
                tags "Database"
            }
            //MS: Pet Service
            pet_service = container "Pet Service" "Stores and manages pet data (breed, age, etc.)" "Spring Boot" {
                tags "MS"
                pets_controller = component "PetsController" "REST controller for pets" "Spring Boot"
                owner_pets_controller = component "OwnerPetsController" "REST controller for owner-specific pet queries" "Spring Boot"
            
                pet_command_service_impl = component "PetCommandServiceImpl" "Implements PetCommandService" "Spring Boot"
                pet_query_service_impl = component "PetQueryServiceImpl" "Implements PetQueryService" "Spring Boot"
            
                pet_command_service = component "PetCommandService" "Defines command operations" "Spring Boot"
                pet_query_service = component "PetQueryService" "Defines query operations" "Spring Boot"
            
                pet_repository = component "PetRepository" "Persists and retrieves Pet entities" "Spring Boot"
 
                external_owner = component "ExternalOwner" "Adapter for Pet Owner Service existence checks" "Spring Boot"
                rest_template_config = component "RestTemplateConfig" "Configures RestTemplate for external calls" "Spring Boot"
            
                resource_assembler = component "PetResourceFromEntityAssembler" "Converts Entity → DTO" "Spring Boot"
                create_assembler = component "CreatePetCommandFromResourceAssembler" "Converts DTO → CreateCommand" "Spring Boot"
                update_assembler = component "UpdatePetCommandFromResourceAssembler" "Converts DTO → UpdateCommand" "Spring Boot"   
            }
            pet_db = container "Pet DB" "PostgreSQL database for pet service" "PostgreSQL" {
                tags "Database"
            }
            //MS: Medical Record Service
            medical_record_service = container "Medical Record Service" "Stores and provides access to pet medical histories" "Spring Boot" {
                tags "MS"
                medical_records_controller = component "MedicalRecordsController" "REST controller for medical records" "Spring Boot"
                diagnostics_medical_record_controller = component "DiagnosticsMedicalRecordController" "REST controller for diagnostics‑specific records" "Spring Boot"
                medical_record_command_service_impl = component "MedicalRecordCommandServiceImpl" "Implements MedicalRecordCommandService" "Spring Boot"
                medical_record_query_service_impl = component "MedicalRecordQueryServiceImpl" "Implements MedicalRecordQueryService" "Spring Boot"
                medical_record_command_service = component "MedicalRecordCommandService" "Defines command operations" "Spring Boot"
                medical_record_query_service = component "MedicalRecordQueryService" "Defines query operations" "Spring Boot"
                medical_record_repository = component "MedicalRecordRepository" "Persists and retrieves MedicalRecord entities" "Spring Boot"
                external_diagnostic = component "ExternalDiagnostic" "Adapter for Diagnostic Service existence checks" "Spring Boot"
                external_appointment = component "ExternalMedicalAppointment" "Adapter for Appointment Service existence checks" "Spring Boot"
                rest_template_config = component "RestTemplateConfig" "Configures RestTemplate for external calls" "Spring Boot"
                resource_assembler = component "MedicalRecordResourceFromEntityAssembler" "Converts Entity → DTO" "Spring Boot"
                create_assembler = component "CreateMedicalRecordCommandFromResourceAssembler" "Converts DTO → CreateCommand" "Spring Boot"
                update_assembler = component "UpdateMedicalRecordCommandFromResourceAssembler" "Converts DTO → UpdateCommand" "Spring Boot"
            }
            medical_db = container "Medical Record DB" "PostgreSQL database for medical records" "PostgreSQL" {
                tags "Database"
                
            }
            //MS: Appointment Service
            appointment_service = container "Appointment Service" "Manages scheduling and tracking of appointments" "Spring Boot" {
                tags "MS"
                appointment_controller = component "AppointmentController" "REST controller for appointments" "Spring Boot"
                tariff_controller = component "TariffController" "REST controller for tariffs" "Spring Boot"
                appointment_command_service_impl = component "AppointmentCommandServiceImpl" "Implements AppointmentCommandService" "Spring Boot"
                appointment_query_service_impl = component "AppointmentQueryServiceImpl" "Implements AppointmentQueryService" "Spring Boot"
                tariff_command_service_impl = component "TariffCommandServiceImpl" "Implements TariffCommandService" "Spring Boot"
                tariff_query_service_impl = component "TariffQueryServiceImpl" "Implements TariffQueryService" "Spring Boot"
                appointment_command_service = component "AppointmentCommandService" "Defines appointment command operations" "Spring Boot"
                appointment_query_service = component "AppointmentQueryService" "Defines appointment query operations" "Spring Boot"
                tariff_command_service = component "TariffCommandService" "Defines tariff command operations" "Spring Boot"
                tariff_query_service = component "TariffQueryService" "Defines tariff query operations" "Spring Boot"
                appointment_repository = component "AppointmentRepository" "Persists and retrieves Appointment aggregates" "Spring Boot"
                tariff_repository = component "TariffRepository" "Persists and retrieves Tariff aggregates" "Spring Boot"
                external_pet = component "ExternalPet" "Adapter for Pet Service existence checks" "Spring Boot"
                external_veterinarian = component "ExternalVeterinarian" "Adapter for Veterinary Service availability checks" "Spring Boot"
                rest_template_config = component "RestTemplateConfig" "Configures RestTemplate for external calls" "Spring Boot"
                appointment_resource_assembler = component "AppointmentResourceAssembler" "Converts Appointment entity → DTO" "Spring Boot"
                create_appointment_assembler = component "CreateAppointmentAssembler" "Converts DTO → CreateAppointmentCommand" "Spring Boot"
                update_appointment_assembler = component "UpdateAppointmentAssembler" "Converts DTO → UpdateAppointmentCommand" "Spring Boot"
                tariff_resource_assembler = component "TariffResourceAssembler" "Converts Tariff entity → DTO" "Spring Boot"
                create_tariff_assembler = component "CreateTariffAssembler" "Converts DTO → CreateTariffCommand" "Spring Boot"
                update_tariff_assembler = component "UpdateTariffAssembler" "Converts DTO → UpdateTariffCommand" "Spring Boot"
            }
            appointment_db = container "Appointment DB" "PostgreSQL database for appointment service" "PostgreSQL" {
                tags "Database"
            }
            //MS: Diagnostic Service
            diagnostic_service = container "Diagnostic Service" "Manages diagnoses and prescriptions" "Spring Boot" {
                tags "MS"
                diagnostic_controller = component "DiagnosticController" "REST controller for diagnostics" "Spring Boot"
                diagnostic_command_service_impl = component "DiagnosticCommandServiceImpl" "Implements DiagnosticCommandService" "Spring Boot"
                diagnostic_query_service_impl = component "DiagnosticQueryServiceImpl" "Implements DiagnosticQueryService" "Spring Boot"
                diagnostic_command_service = component "DiagnosticCommandService" "Defines command operations" "Spring Boot"
                diagnostic_query_service = component "DiagnosticQueryService" "Defines query operations" "Spring Boot"
                diagnostic_repository = component "DiagnosticRepository" "Persists and retrieves Diagnostic entities" "Spring Boot"
                resource_assembler = component "DiagnosticResourceFromEntityAssembler" "Converts Entity → DTO" "Spring Boot"
                create_assembler = component "CreateDiagnosticCommandFromResourceAssembler" "Converts DTO → CreateDiagnosticCommand" "Spring Boot"
                update_assembler = component "UpdateDiagnosticCommandFromResourceAssembler" "Converts DTO → UpdateDiagnosticCommand" "Spring Boot"
            }
            diagnostic_db = container "Diagnostic DB" "PostgreSQL database for diagnostic service" "PostgreSQL" {
                tags "Database"
            }
            //MS: Feedback Service
            review_service = container "Review Service" "Handles reviews and ratings from clients" "Spring Boot" {
                tags "MS"
                review_controller = component "ReviewController" "REST controller for reviews" "Spring Boot"
                review_command_service_impl = component "ReviewCommandServiceImpl" "Implements ReviewCommandService" "Spring Boot"
                review_query_service_impl = component "ReviewQueryServiceImpl" "Implements ReviewQueryService" "Spring Boot"
                review_command_service = component "ReviewCommandService" "Defines command operations" "Spring Boot"
                review_query_service = component "ReviewQueryService" "Defines query operations" "Spring Boot"
                review_repository = component "ReviewRepository" "Persists and retrieves Review entities" "Spring Boot" 
                external_appointment = component "ExternalMedicalAppointment" "Adapter for Appointment Service existence checks" "Spring Boot"
                rest_template_config = component "RestTemplateConfig" "Configures RestTemplate for external calls" "Spring Boot" 
                review_resource_assembler = component "ReviewResourceFromEntityAssembler" "Converts Entity → DTO" "Spring Boot"
                create_review_assembler = component "CreateReviewCommandFromResourceAssembler" "Converts DTO → CreateReviewCommand" "Spring Boot"
                update_review_assembler = component "UpdateReviewCommandFromResourceAssembler" "Converts DTO → UpdateReviewCommand" "Spring Boot"
            }
            review_db = container "Review DB" "PostgreSQL database for review service" "PostgreSQL" {
                tags "Database"
            }
            
            
        }
        
        /* ************************************************** */
        /* Context Diagram Relations */
        /* ************************************************** */
        
        user_1 -> ss "Uses"
        user_2 -> ss "Uses"
        ss -> external_s1 "Uses"
        ss -> external_s2 "Uses"
        
        /* ************************************************** */
        /* Container Diagram Relations */
        /* ************************************************** */
        
        // General Relationships
        user_1 -> ss.lp "Visits"
        user_2 -> ss.lp "Visits"
        ss.lp -> ss.wa "Redirects to"
        ss.wa -> ss.api "Uses"
        ss.wa -> external_s2 "Uses"
        ss.account_service -> external_s1 "Uses"
        ss.api -> ss.registry_service "Uses"
        //Eureka Server Discovery Clients relations
        ss.registry_service -> ss.account_service "Uses"
        ss.registry_service -> ss.appointment_service "Uses"
        ss.registry_service -> ss.review_service "Uses"
        ss.registry_service -> ss.pet_service "Uses"
        ss.registry_service -> ss.medical_record_service "Uses"
        ss.registry_service -> ss.diagnostic_service "Uses"
        ss.registry_service -> ss.veterinary_service "Uses"
        ss.registry_service -> ss.schedule_service "Uses"
        ss.registry_service -> ss.pet_owner_service "Uses"
        // One-to-one DB relations
        ss.account_service -> ss.account_db "Reads from and writes to"
        ss.appointment_service -> ss.appointment_db "Reads from and writes to"
        ss.review_service -> ss.review_db "Reads from and writes to"
        ss.pet_service -> ss.pet_db "Reads from and writes to"
        ss.medical_record_service -> ss.medical_db "Reads from and writes to"
        ss.diagnostic_service -> ss.diagnostic_db "Reads from and writes to"
        ss.veterinary_service -> ss.veterinary_db "Reads from and writes to"
        ss.schedule_service -> ss.schedule_db "Reads from and writes to"
        ss.pet_owner_service -> ss.pet_owner_db "Reads from and writes to"
        //Interservices communication
        ss.pet_service -> ss.pet_owner_service "Calls"
        ss.schedule_service -> ss.veterinary_service "Calls"
        ss.appointment_service -> ss.pet_service "Calls"
        ss.appointment_service -> ss.veterinary_service "Calls"
        ss.appointment_service -> ss.review_service "Calls"
        ss.appointment_service -> ss.medical_record_service "Calls"
        ss.medical_record_service -> ss.diagnostic_service "Calls"
        
        /* ************************************************** */
        /* Account Service Component Diagram Relations */
        /* ************************************************** */
        
        // Account Service Component Diagram Relations

        // Internal component relationships
        ss.account_service.authentication_controller       -> ss.account_service.user_admin_command_service_impl   "invokes"
        ss.account_service.authentication_controller       -> ss.account_service.user_admin_query_service_impl     "invokes"
        ss.account_service.google_authentication_controller -> ss.account_service.user_admin_command_service_impl   "invokes"
        ss.account_service.roles_controller                -> ss.account_service.role_command_service_impl         "invokes"
        ss.account_service.roles_controller                -> ss.account_service.role_query_service_impl           "invokes"
        ss.account_service.users_admin_controller          -> ss.account_service.user_admin_command_service_impl   "invokes"
        ss.account_service.users_admin_controller          -> ss.account_service.user_admin_query_service_impl     "invokes"
        
        ss.account_service.role_command_service_impl       -> ss.account_service.role_command_service              "implements"
        ss.account_service.user_admin_command_service_impl -> ss.account_service.user_admin_command_service        "implements"
        ss.account_service.role_query_service_impl         -> ss.account_service.role_query_service                "implements"
        ss.account_service.user_admin_query_service_impl   -> ss.account_service.user_admin_query_service          "implements"
        
        ss.account_service.application_ready_event_handler -> ss.account_service.role_command_service_impl         "initializes default roles"
        
        ss.account_service.user_admin_command_service_impl -> ss.account_service.user_admin_repository             "persists data to"
        ss.account_service.user_admin_query_service_impl   -> ss.account_service.user_admin_repository             "queries data from"
        ss.account_service.role_command_service_impl       -> ss.account_service.role_repository                   "persists data to"
        ss.account_service.role_query_service_impl         -> ss.account_service.role_repository                   "queries data from"
        
        ss.account_service.user_admin_command_service_impl -> ss.account_service.bcrypt_password_encoder           "hashes passwords"
        ss.account_service.user_admin_command_service_impl -> ss.account_service.jwt_provider                      "generates tokens"
        ss.account_service.authentication_controller       -> ss.account_service.jwt_provider                      "validates tokens"
        
        ss.account_service.google_authentication_controller -> ss.account_service.google_oauth_client               "uses"
        ss.account_service.google_oauth_client              -> external_s1                                         "uses API of"
        
        // External relationships
        ss.account_service.role_repository                  -> ss.account_db                                        "reads from and writes to"
        ss.account_service.user_admin_repository            -> ss.account_db                                        "reads from and writes to"
        ss.registry_service                                 -> ss.account_service.authentication_controller         "discovers"
        ss.registry_service                                 -> ss.account_service.google_authentication_controller  "discovers"
        ss.registry_service                                 -> ss.account_service.roles_controller                  "discovers"
        ss.registry_service                                 -> ss.account_service.users_admin_controller            "discovers"
                
        
        
        /* ************************************************** */
        /* Veterinary Service Component Diagram Relations */
        /* ************************************************** */
        
        // VETERINARY SERVICE
        // Internal component relationships
        ss.veterinary_service.veterinarians_controller -> ss.veterinary_service.veterinarian_command_service_impl "invokes"
        ss.veterinary_service.veterinarians_controller -> ss.veterinary_service.veterinarian_query_service_impl "invokes"
        
        ss.veterinary_service.veterinarian_command_service_impl -> ss.veterinary_service.veterinarian_command_service "implements"
        ss.veterinary_service.veterinarian_query_service_impl -> ss.veterinary_service.veterinarian_query_service "implements"
        
        ss.veterinary_service.veterinarian_command_service_impl -> ss.veterinary_service.veterinarian_repository "persists data to"
        ss.veterinary_service.veterinarian_query_service_impl -> ss.veterinary_service.veterinarian_repository "queries data from"
        
        ss.veterinary_service.veterinarians_controller -> ss.veterinary_service.resource_assembler "uses"
        ss.veterinary_service.veterinarians_controller -> ss.veterinary_service.create_assembler "uses"
        ss.veterinary_service.veterinarians_controller -> ss.veterinary_service.update_assembler "uses"
        ss.veterinary_service.veterinarians_controller -> ss.veterinary_service.availability_assembler "uses"       
        
        
        // External relationships
        ss.schedule_service -> ss.veterinary_service.veterinarians_controller "calls for availability"
        ss.registry_service -> ss.veterinary_service.veterinarians_controller "discovers"
        ss.veterinary_service.veterinarian_repository  -> ss.veterinary_db "reads from and writes to"
        
        
        /* ************************************************** */
        /* Schedule Service Component Diagram Relations */
        /* ************************************************** */
        
        // SCHEDULE SERVICE
        // Internal component relationships
        ss.schedule_service.schedule_controller -> ss.schedule_service.schedule_command_service_impl "invokes"
        ss.schedule_service.schedule_controller -> ss.schedule_service.schedule_query_service_impl "invokes"
        ss.schedule_service.vet_schedule_controller -> ss.schedule_service.schedule_query_service_impl "invokes"
        
        ss.schedule_service.schedule_command_service_impl -> ss.schedule_service.schedule_command_service "implements"
        ss.schedule_service.schedule_query_service_impl -> ss.schedule_service.schedule_query_service "implements"
        
        ss.schedule_service.schedule_command_service_impl -> ss.schedule_service.schedule_repository "persists data to"
        ss.schedule_service.schedule_query_service_impl -> ss.schedule_service.schedule_repository "queries data from"
        
        ss.schedule_service.schedule_controller -> ss.schedule_service.resource_assembler "uses"
        ss.schedule_service.schedule_controller -> ss.schedule_service.create_assembler "uses"
        ss.schedule_service.schedule_controller -> ss.schedule_service.update_assembler "uses"
        ss.schedule_service.vet_schedule_controller -> ss.schedule_service.resource_assembler "uses"
        
        ss.schedule_service.schedule_command_service_impl -> ss.schedule_service.external_veterinarian "calls for availability"
        ss.schedule_service.external_veterinarian -> ss.schedule_service.rest_template_config "uses"
        
        // External relationships
        ss.registry_service -> ss.schedule_service.schedule_controller "discovers"
        ss.schedule_service.schedule_repository -> ss.schedule_db "reads from and writes to"
        ss.schedule_service.external_veterinarian -> ss.veterinary_service "updates availability"
        
        
        /* ************************************************** */
        /* Pet Owner Service Component Diagram Relations */
        /* ************************************************** */
        
        // Pet Owner Service Component Diagram Relations

        // Internal component relationships
        ss.pet_owner_service.pet_owners_controller -> ss.pet_owner_service.pet_owner_command_service_impl "invokes"
        ss.pet_owner_service.pet_owners_controller -> ss.pet_owner_service.pet_owner_query_service_impl "invokes"
        
        ss.pet_owner_service.pet_owner_command_service_impl -> ss.pet_owner_service.pet_owner_command_service "implements"
        ss.pet_owner_service.pet_owner_query_service_impl -> ss.pet_owner_service.pet_owner_query_service "implements"
 
        ss.pet_owner_service.pet_owner_command_service_impl -> ss.pet_owner_service.pet_owner_repository "persists data to"
        ss.pet_owner_service.pet_owner_query_service_impl -> ss.pet_owner_service.pet_owner_repository "queries data from"
        
        ss.pet_owner_service.pet_owners_controller -> ss.pet_owner_service.resource_assembler "uses"
        ss.pet_owner_service.pet_owners_controller -> ss.pet_owner_service.create_assembler "uses"
        ss.pet_owner_service.pet_owners_controller -> ss.pet_owner_service.update_assembler "uses"
        
        // External relationships
        ss.registry_service -> ss.pet_owner_service.pet_owners_controller "discovers"
        ss.pet_service -> ss.pet_owner_service.pet_owners_controller "calls for information"
        ss.pet_owner_service.pet_owner_repository -> ss.pet_owner_db "reads from and writes to"
        
        /* ************************************************** */
        /* Pet Service Component Diagram Relations */
        /* ************************************************** */
        // Pet Service Component Diagram Relations

        // Internal component relationships
        ss.pet_service.pets_controller -> ss.pet_service.pet_command_service_impl "invokes"
        ss.pet_service.pets_controller -> ss.pet_service.pet_query_service_impl "invokes"
        ss.pet_service.owner_pets_controller -> ss.pet_service.pet_query_service_impl "invokes"
        
        ss.pet_service.pet_command_service_impl -> ss.pet_service.pet_command_service "implements"
        ss.pet_service.pet_query_service_impl -> ss.pet_service.pet_query_service "implements"
        
        ss.pet_service.pet_command_service_impl -> ss.pet_service.pet_repository "persists data to"
        ss.pet_service.pet_query_service_impl -> ss.pet_service.pet_repository "queries data from"
        
        ss.pet_service.pets_controller -> ss.pet_service.resource_assembler "uses"
        ss.pet_service.pets_controller -> ss.pet_service.create_assembler "uses"
        ss.pet_service.pets_controller -> ss.pet_service.update_assembler "uses"
        ss.pet_service.owner_pets_controller -> ss.pet_service.resource_assembler "uses"
        
        ss.pet_service.pet_command_service_impl -> ss.pet_service.external_owner "verifies existence"
        ss.pet_service.external_owner -> ss.pet_service.rest_template_config "uses"
        
        // External  
        ss.registry_service -> ss.pet_service.pets_controller "discovers"
        ss.pet_service.external_owner -> ss.pet_owner_service "calls for information"
        ss.pet_service.pet_repository -> ss.pet_db "reads from and writes to"
        
        /* ************************************************** */
        /* Medical Record Service Component Diagram Relations */
        /* ************************************************** */
        // Medical Record Service Component Diagram Relations

        // Internal component relationships
        ss.medical_record_service.medical_records_controller -> ss.medical_record_service.medical_record_command_service_impl "invokes"
        ss.medical_record_service.medical_records_controller -> ss.medical_record_service.medical_record_query_service_impl "invokes"
        ss.medical_record_service.diagnostics_medical_record_controller -> ss.medical_record_service.medical_record_query_service_impl "invokes"
        
        ss.medical_record_service.medical_record_command_service_impl -> ss.medical_record_service.medical_record_command_service "implements"
        ss.medical_record_service.medical_record_query_service_impl -> ss.medical_record_service.medical_record_query_service "implements"
        
        ss.medical_record_service.medical_record_command_service_impl -> ss.medical_record_service.medical_record_repository "persists data to"
        ss.medical_record_service.medical_record_query_service_impl -> ss.medical_record_service.medical_record_repository "queries data from"
        
        ss.medical_record_service.medical_records_controller -> ss.medical_record_service.resource_assembler "uses"
        ss.medical_record_service.medical_records_controller -> ss.medical_record_service.create_assembler "uses"
        ss.medical_record_service.medical_records_controller -> ss.medical_record_service.update_assembler "uses"
        ss.medical_record_service.diagnostics_medical_record_controller -> ss.medical_record_service.resource_assembler "uses"
        
        // External calls via adapters
        ss.medical_record_service.medical_record_command_service_impl -> ss.medical_record_service.external_diagnostic "verifies existence"
        ss.medical_record_service.medical_record_command_service_impl -> ss.medical_record_service.external_appointment "verifies existence"
        ss.medical_record_service.external_diagnostic -> ss.medical_record_service.rest_template_config "uses"
        ss.medical_record_service.external_appointment -> ss.medical_record_service.rest_template_config "uses"
        
        // External relationships
        ss.registry_service -> ss.medical_record_service.medical_records_controller "discovers"
        ss.medical_record_service.medical_record_repository -> ss.medical_db "reads from and writes to"
        ss.medical_record_service.external_diagnostic -> ss.diagnostic_service "calls for information"
        ss.medical_record_service.external_appointment -> ss.appointment_service "calls for information"
        ss.diagnostic_service -> ss.medical_record_service.diagnostics_medical_record_controller "supplies diagnostic context"
                
        
        /* ************************************************** */
        /* Appoiment Service Component Diagram Relations */
        /* ************************************************** */
        // Appointment Service Component Diagram Relations

        // Internal component relationships
        ss.appointment_service.appointment_controller -> ss.appointment_service.appointment_command_service_impl "invokes"
        ss.appointment_service.appointment_controller -> ss.appointment_service.appointment_query_service_impl "invokes"
        ss.appointment_service.tariff_controller -> ss.appointment_service.tariff_command_service_impl "invokes"
        ss.appointment_service.tariff_controller -> ss.appointment_service.tariff_query_service_impl "invokes"
        
        ss.appointment_service.appointment_command_service_impl -> ss.appointment_service.appointment_command_service "implements"
        ss.appointment_service.appointment_query_service_impl -> ss.appointment_service.appointment_query_service "implements"
        ss.appointment_service.tariff_command_service_impl -> ss.appointment_service.tariff_command_service "implements"
        ss.appointment_service.tariff_query_service_impl -> ss.appointment_service.tariff_query_service "implements"
        
        ss.appointment_service.appointment_command_service_impl -> ss.appointment_service.appointment_repository "persists data to"
        ss.appointment_service.appointment_query_service_impl -> ss.appointment_service.appointment_repository "queries data from"
        ss.appointment_service.tariff_command_service_impl -> ss.appointment_service.tariff_repository "persists data to"
        ss.appointment_service.tariff_query_service_impl -> ss.appointment_service.tariff_repository "queries data from"
        
        ss.appointment_service.appointment_controller -> ss.appointment_service.appointment_resource_assembler "uses"
        ss.appointment_service.appointment_controller -> ss.appointment_service.create_appointment_assembler "uses"
        ss.appointment_service.appointment_controller -> ss.appointment_service.update_appointment_assembler "uses"
        ss.appointment_service.tariff_controller -> ss.appointment_service.tariff_resource_assembler "uses"
        ss.appointment_service.tariff_controller -> ss.appointment_service.create_tariff_assembler "uses"
        ss.appointment_service.tariff_controller -> ss.appointment_service.update_tariff_assembler "uses"
        
        // External calls via adapters
        ss.appointment_service.appointment_command_service_impl -> ss.appointment_service.external_pet "verifies existence"
        ss.appointment_service.appointment_command_service_impl -> ss.appointment_service.external_veterinarian "verifies availability"
        ss.appointment_service.external_pet -> ss.appointment_service.rest_template_config "uses"
        ss.appointment_service.external_veterinarian -> ss.appointment_service.rest_template_config "uses"
        
        // External relationships
        ss.registry_service -> ss.appointment_service.appointment_controller "discovers"
        ss.registry_service -> ss.appointment_service.tariff_controller "discovers"
        ss.appointment_service.appointment_repository -> ss.appointment_db "reads from and writes to"
        ss.appointment_service.tariff_repository -> ss.appointment_db "reads from and writes to"
        ss.appointment_service.external_pet -> ss.pet_service "calls for information"
        ss.appointment_service.external_veterinarian -> ss.veterinary_service "calls for information"
        ss.appointment_service.appointment_controller -> ss.medical_record_service "creates medical records"
                
        
        /* ************************************************** */
        /* Diagnostic Service Component Diagram Relations */
        /* ************************************************** */
        
        // Diagnostic Service Component Diagram Relations

        // Internal component relationships
        ss.diagnostic_service.diagnostic_controller -> ss.diagnostic_service.diagnostic_command_service_impl "invokes"
        ss.diagnostic_service.diagnostic_controller -> ss.diagnostic_service.diagnostic_query_service_impl "invokes"
        
        ss.diagnostic_service.diagnostic_command_service_impl -> ss.diagnostic_service.diagnostic_command_service "implements"
        ss.diagnostic_service.diagnostic_query_service_impl -> ss.diagnostic_service.diagnostic_query_service "implements"
        
        ss.diagnostic_service.diagnostic_controller -> ss.diagnostic_service.resource_assembler "uses"
        ss.diagnostic_service.diagnostic_controller -> ss.diagnostic_service.create_assembler "uses"
        ss.diagnostic_service.diagnostic_controller -> ss.diagnostic_service.update_assembler "uses"
 
        ss.diagnostic_service.diagnostic_command_service_impl -> ss.diagnostic_service.diagnostic_repository "persists data to"
        ss.diagnostic_service.diagnostic_query_service_impl -> ss.diagnostic_service.diagnostic_repository "queries data from"
        
        // External relationships
        ss.registry_service -> ss.diagnostic_service.diagnostic_controller "discovers"
        ss.diagnostic_service.diagnostic_repository -> ss.diagnostic_db "reads from and writes to"
        ss.medical_record_service -> ss.diagnostic_service.diagnostic_controller "requests diagnostic information"
        
        /* ************************************************** */
        /* Review Service Component Diagram Relations */
        /* ************************************************** */
        
        // Review Service Component Diagram Relations

        // Internal component relationships
        ss.review_service.review_controller -> ss.review_service.review_command_service_impl "invokes"
        ss.review_service.review_controller -> ss.review_service.review_query_service_impl "invokes"
        
        ss.review_service.review_command_service_impl -> ss.review_service.review_command_service "implements"
        ss.review_service.review_query_service_impl -> ss.review_service.review_query_service "implements"
        
        ss.review_service.review_command_service_impl -> ss.review_service.review_repository "persists data to"
        ss.review_service.review_query_service_impl -> ss.review_service.review_repository "queries data from"
        
        ss.review_service.review_controller -> ss.review_service.review_resource_assembler "uses"
        ss.review_service.review_controller -> ss.review_service.create_review_assembler "uses"
        ss.review_service.review_controller -> ss.review_service.update_review_assembler "uses"
        
        // External calls via adapter
        ss.review_service.review_command_service_impl -> ss.review_service.external_appointment "verifies existence"
        ss.review_service.external_appointment -> ss.review_service.rest_template_config "uses"
        
        // External relationships
        ss.registry_service -> ss.review_service.review_controller "discovers"
        ss.review_service.review_repository -> ss.review_db "reads from and writes to"
        ss.review_service.external_appointment -> ss.appointment_service  "calls for information"
    }

    views {
        systemContext ss "DiagramaContexto" {
            include *
            autolayout lr
        }

        container ss "DiagramContenedores" {
            include *
            autolayout lr
        }
        
        component ss.account_service "AccountServiceComponentDiagram" {
            include *
            autolayout
        }
        component ss.veterinary_service "VeterinaryServiceComponentDiagram" {
            include *
            autolayout
        }
        component ss.schedule_service "ScheduleServiceComponentDiagram" {
            include *
            autolayout
        }
        component ss.pet_owner_service "PetOwnerServiceComponentDiagram" {
            include *
            autolayout
        }
        component ss.pet_service "PetServiceComponentDiagram" {
            include *
            autolayout
        }
        component ss.medical_record_service "MedicalRecordServiceComponentDiagram" {
            include *
            autolayout
        }
        component ss.appointment_service "AppointmentServiceComponentDiagram" {
            include *
            autolayout
        }
        component ss.diagnostic_service "DiagnosticServiceComponentDiagram" {
            include *
            autolayout
        }
        component ss.review_service "ReviewServiceComponentDiagram" {
            include *
            autolayout
        }

        styles {
            element "Person" {
                background #08427b
                color #ffffff
                shape person
            }
            element "Usuario" {
                shape "Person" 
                background "#39b56e" 
                color "#ffffff" 
            }
            element "veterinario" {
                shape "Person" 
                background "#7bb9e4" 
                color "#ffffff" 
            }

            element "Software System" {
                background #1168bd
                color #ffffff
                shape roundedbox
            }
            element "Container" {
                background #438dd5
                color #ffffff
            }

            element "Database" {
                shape cylinder
                background #f5da55
                color #000000
            }
            element "External System" {
                background #7B7B7B
                color #ffffff
            }
            element "MS" {
                shape "RoundedBox" 
                background "#22b140" 
            }
            element "Gateway" {
                shape "RoundedBox" 
                background "#e48927" 
            }
            element "WebPage" {
                shape "WebBrowser" 
                background "#216ece" 
            }
            
             element "Component" {
                shape "RoundedBox" 
                background "#85bbf0"
                color "#000000"
            }
        }
    }

}