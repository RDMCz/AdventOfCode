package aoc2021;

import java.util.ArrayList;
import java.util.List;

public class d12p1 {
    
    static List<String> paths = new ArrayList<>();
    
    public static void main(String[] args) throws Exception {
        
        String[] input = AoC2021.loadFile("d12p1");
        
        List<Cave> caves = new ArrayList<>();
        
        for (String line : input) {
            for (String caveName : line.split("-")) {                
                boolean fresh = true;                
                for (Cave cave : caves) {
                    if (cave.name.equals(caveName)) {                        
                        fresh = false;
                        break;
                    }                    
                }
                if (fresh) caves.add(new Cave(caveName));                
            }
        }
        
        for (String line : input) {
            Cave crntCave = null;
            Cave neigh = null;
            String[] parts = line.split("-");
            for (Cave cave : caves) {
                if (parts[0].equals(cave.name)) crntCave = cave;
                if (parts[1].equals(cave.name)) neigh = cave;
            }            
            crntCave.adjanced.add(neigh);
            if (!crntCave.name.equals("start") && !neigh.name.equals("end")) {
                neigh.adjanced.add(crntCave);
            }
        }
        
        for (Cave cave : caves) {
            if (cave.name.equals("start")) {                
                for (Cave neigh : cave.adjanced) {
                    neigh.seek("start,");
                }                
                break;
            }
        }
        
        //for (String path : paths) System.out.println(path);
        
        System.out.println(paths.size());
    }

}

class Cave {
    
    String name;    
    List<Cave> adjanced;
    
    public Cave(String name) {
        this.name = name;        
        this.adjanced = new ArrayList<>();
    }    
    
    void seek(String path) {                
        // Kontrola, zdali v cest?? nen?? n??jak?? small cave v??cekr??t (dvakr??t); pokud ano, tato cesta se zahod??
        String[] parts = path.split(",");
        List<String> caves = new ArrayList<>();
        for (String item : parts) {
            if (caves.contains(item) && Character.isLowerCase(item.charAt(0))) {
                return;
            }
            else {
                caves.add(item);
            }
        }
        // Cesta kon???? v end
        if (name.equals("end")) {
            String finalPath = path + "end";
            d12p1.paths.add(finalPath);
            return;
        }
        // Pokud je??t?? nedo??el do end, p??id?? do cesty sama sebe a zavol?? tuto metodu na v??echny sousedy
        for (Cave neigh : adjanced) {            
            neigh.seek(path + name + ",");
        }        
    }
    
    /*@Override public String toString() { 
        String neigh = "";
        for (Cave cave : adjanced) neigh += cave.name + ", ";
        return(name + " - " + neigh); 
    }*/
}
