/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mif_data_generator;

import java.awt.Color;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import javax.imageio.ImageIO;

/**
 *
 * @author Team Neurun
 */
public class Mif_data_generator {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) throws FileNotFoundException, UnsupportedEncodingException {
        
        // Change this
        String file_url = "C:\\Users\\noahp\\Desktop\\mif_gen\\line.png";
        String image_name = "letter";
        //
        
        // Shouldn't have to change this:
        int width = 24;
        int depth = 307200;
        String address_radix = "ADDRESS_RADIX=HEX;";
        String data_radix = "DATA_RADIX=HEX;";
        //
        
        File file = new File(file_url);
        BufferedImage image = null;
        PrintWriter writer = new PrintWriter("C:\\Users\\noahp\\Desktop\\mif_gen\\messenger_data.txt", "UTF-8");
        
        // Header:
        writer.println("-- Memory Initialization File for " + image_name + " data");
        writer.println();
        writer.println("WIDTH=" + width + ";");
        writer.println("DEPTH=" + depth + ";");
        writer.println();
        writer.println(address_radix);
        writer.println(data_radix);
        writer.println();
        
        // Content:
        writer.println("CONTENT BEGIN");         
        try
        {
            image = ImageIO.read(file);
             
            for (int y = 0; y < image.getHeight(); y++) {
                for (int x = 0; x < image.getWidth(); x++) {
                    Color c = new Color(image.getRGB(x, y));
                    String hexcode = String.format("%02x%02x%02x", c.getRed(),c.getGreen(),c.getBlue());
                    
                    int counter = y*image.getWidth() + x;
                    String counterHex =Integer.toHexString(counter);
                    
                    // Make hex 3-digit
                    if (counterHex.length() == 1) counterHex = "00" + counterHex;
                    else if (counterHex.length() == 2) counterHex = "0" + counterHex;

                    writer.println("    " + counterHex + "  :   " + counterHex + ";");
                    
                }
            }
            writer.println("END;");
            writer.close();

        } 
        catch (IOException e) 
        {
            e.printStackTrace();
        }
    }
}
