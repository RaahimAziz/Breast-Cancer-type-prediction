# Install necessary packages if not installed
# install.packages("shiny")
# install.packages("shinythemes")
# install.packages("caret")

library(shiny)
library(shinythemes)
library(caret)

# Define the UI of the Shiny App
ui <- fluidPage(
  
  # Apply a modern and soft theme
  theme = shinytheme("cyborg"),
  
  # App title
  titlePanel("Breast Cancer Subtype Prediction"),
  
  # Sidebar layout with input controls
  sidebarLayout(
    sidebarPanel(
      # Collect patient inputs for prediction
      
      selectInput("Relapse_Free_Status", "Relapse Free Status", 
                  choices = c("No relapse", "Relapse")),
      
      selectInput("Sex", "Sex", 
                  choices = c("Male", "Female")),
      
      selectInput("Cancer_Type", "Cancer Type", 
                  choices = c("Invasive Ductal Carcinoma", "Invasive Lobular Carcinoma", "Other")),
      
      selectInput("Primary_Tumor_Laterality", "Primary Tumor Laterality", 
                  choices = c("Left", "Right", "Bilateral")),
      
      selectInput("Type_of_Breast_Surgery", "Type of Breast Surgery", 
                  choices = c("Mastectomy", "Lumpectomy")),
      
      selectInput("Tumor_Stage", "Tumor Stage", 
                  choices = c("Stage 1", "Stage 2", "Stage 3", "Stage 4")),
      
      selectInput("Neoplasm_Histologic_Grade", "Neoplasm Histologic Grade", 
                  choices = c("Grade 1", "Grade 2", "Grade 3")),
      
      selectInput("HER2_status_measured_by_SNP6", "HER2 Status (SNP6)", 
                  choices = c("Positive", "Negative")),
      
      selectInput("Inferred_Menopausal_State", "Inferred Menopausal State", 
                  choices = c("Pre-menopausal", "Post-menopausal")),
      
      actionButton("predict_button", "Predict Subtype", 
                   class = "btn btn-primary")
    ),
    
    # Main panel for displaying the prediction result
    mainPanel(
      h3("Prediction Result"),
      verbatimTextOutput("predictionResult")
    )
  )
)

# Define server logic for the Shiny App
server <- function(input, output) {
  
  # Reactive function to make a prediction based on patient input
  observeEvent(input$predict_button, {
    
    # Collect the input from the patient
    patient_data <- data.frame(
      Relapse.Free.Status = as.numeric(factor(input$Relapse_Free_Status, levels = c("No relapse", "Relapse"))),
      Sex = as.numeric(factor(input$Sex, levels = c("Male", "Female"))),
      Cancer.Type = as.numeric(factor(input$Cancer_Type, levels = c("Invasive Ductal Carcinoma", "Invasive Lobular Carcinoma", "Other"))),
      Primary.Tumor.Laterality = as.numeric(factor(input$Primary_Tumor_Laterality, levels = c("Left", "Right", "Bilateral"))),
      Type.of.Breast.Surgery = as.numeric(factor(input$Type_of_Breast_Surgery, levels = c("Mastectomy", "Lumpectomy"))),
      Tumor.Stage = as.numeric(factor(input$Tumor_Stage, levels = c("Stage 1", "Stage 2", "Stage 3", "Stage 4"))),
      Neoplasm.Histologic.Grade = as.numeric(factor(input$Neoplasm_Histologic_Grade, levels = c("Grade 1", "Grade 2", "Grade 3"))),
      HER2.status.measured.by.SNP6 = as.numeric(factor(input$HER2_status_measured_by_SNP6, levels = c("Positive", "Negative"))),
      Inferred.Menopausal.State = as.numeric(factor(input$Inferred_Menopausal_State, levels = c("Pre-menopausal", "Post-menopausal")))
    )
    
    # Here, you would connect the patient_data to the logistic regression model you have trained
    # For this example, I will simulate the prediction
    # Replace the following line with your model's prediction code
    prediction <- "Simulated Subtype Prediction"
    
    # Display the prediction result
    output$predictionResult <- renderText({
      paste("Predicted Breast Cancer Subtype:", prediction)
    })
    
  })
}

# Run the application
shinyApp(ui = ui, server = server)
