from kivy.app import App
from kivy.lang import Builder


class MainApp(App):
    def UpdateScreen(self):
        self.root.ids.lab_time.text    = self.PrintTime(self.meat, self.doneness, self.thickness)
        self.root.ids.lab_degrees.text = self.PrintDegrees(self.meat, self.doneness)
    
    def PrintThickness(self, thickness):
        return f"Thickness: {thickness} cm / {round((thickness/2.54), 2)} ″"
    
    def PrintDegrees(self, meat, doneness):
        degreesC = self.degrees[meat][doneness]
        return f"{degreesC} °C\n{round(degreesC * 1.8 + 32 + 0.5)} °F"
    
    def PrintTime(self, meat, doneness, thickness):
        beta = self.betas[self.degrees[meat][doneness]]
        mins = round(self.intercept + (thickness**2) * beta + 0.5) # Ceiling to be safe
        mins = mins + (mins % 60)
        h    = mins // 60
        m    = mins  % 60
        return f"{h}h {m}min" if h > 0 else f"{m}min"


    def build(self):
        self.title = "SousVideApp"
        
        self.colPrimary   = [ 65/256,  90/256, 119/256, 1]
        self.colSecondary = [ 27/256,  38/256,  59/256, 1]
        self.colTertiary  = [ 13/256,  27/256,  42/256, 1]
        self.colBorder    = [      0,       0,       0, 1]

        self.meat = "Beef"
        self.doneness = "Medium rare"
        self.thickness = 3.5
        
        self.intercept = 2.301695
        self.betas = { 49: 4.427493, 50: 4.698701, 55: 5.106174, 60: 5.354965, 65: 5.489031 }
        
        self.degrees = {
            "Poultry": {"Medium rare": 60, "Medium": 60, "Well done": 65},
            "Fish":    {"Medium rare": 49, "Medium": 55, "Well done": 60},
            "Pork":    {"Medium rare": 55, "Medium": 60, "Well done": 65},
            "Beef":    {"Medium rare": 55, "Medium": 60, "Well done": 65}
        }
        
        return Builder.load_file("design.kv")


if __name__ == "__main__":
    MainApp().run()

