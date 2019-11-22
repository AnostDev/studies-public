import pandas as pd
import matplotlib.pyplot as plt

if __name__ == '__main__':

    headers = ["Date", "Hour", "Depth", "Temperature", "Density", "ColonyDiameter", "Species"]
    filePath = "/home/chriss/Desktop/studies/amu/m2/gestion-des-donnees/tps/tp5/plancton/resources/plancton.csv"
    planctonData = pd.read_csv(filePath, ";")

    print(planctonData.info())
    print(planctonData.describe())

    density = planctonData["Density"]
    hour = planctonData["Hour"]

    density_cuni = planctonData.filter(axis=0, like='cuni')


    plt.xticks(rotation=90)
    plt.plot(hour, density)
    plt.xlabel("Hour")
    plt.ylabel("Density")
    plt.show()
ju
    names = [""]
