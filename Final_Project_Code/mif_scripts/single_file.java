/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mif_generator;

import java.awt.Color;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import javax.imageio.ImageIO;

/**
 *
 * @author Team Neurun
 */
public class single_file {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) throws FileNotFoundException, UnsupportedEncodingException {
        
        // Change this
        String file_url = "C:\\Users\\noahp\\Desktop\\mif_gen\\b.png";
        
        String image_name = "test circle";
        HashSet<String> hset = new HashSet<String>();
        
        // Shouldn't have to change this:
        String address_radix = "ADDRESS_RADIX=HEX;";
        String data_radix = "DATA_RADIX=HEX;";
        //
        
        File file = new File(file_url);
        BufferedImage image = null;
        BufferedImage second_image = null;
        PrintWriter writer_index = new PrintWriter("C:\\Users\\noahp\\Desktop\\mif_gen\\messenger_index.txt", "UTF-8");
        PrintWriter writer_data = new PrintWriter("C:\\Users\\noahp\\Desktop\\mif_gen\\messenger_data.txt", "UTF-8");
        
        try
        {
            image = ImageIO.read(file);
             
            for (int y = 0; y < image.getHeight(); y++) {
                for (int x = 0; x < image.getWidth(); x++) {
                    Color c = new Color(image.getRGB(x, y));
                    //System.out.println("red: " + c.getRed() + " green: " + c.getGreen() + " blue: " + c.getBlue());
                    String hexcode = String.format("%02x%02x%02x", c.getRed(),c.getGreen(),c.getBlue());
                    hset.add(hexcode);
                }
                
            }
        }
                    
        catch (IOException e) 
        {
            e.printStackTrace();
        } 

        List<String> all_colors = new ArrayList<String>(hset);
        int width_index = 24;
        int depth_index = all_colors.size();
        
        int width_data = 24;
        int depth_data = 576;
    
        // Header:
        writer_index.println("-- Memory Initialization File for " + image_name);
        writer_index.println();
        writer_index.println("WIDTH=" + width_index + ";");
        writer_index.println("DEPTH=" + depth_index + ";");
        writer_index.println();
        writer_index.println(address_radix);
        writer_index.println(data_radix);
        writer_index.println();
        
        writer_data.println("-- Memory Initialization File for " + image_name);
        writer_data.println();
        writer_data.println("WIDTH=" + width_data + ";");
        writer_data.println("DEPTH=" + depth_data + ";");
        writer_data.println();
        writer_data.println(address_radix);
        writer_data.println(data_radix);
        writer_data.println();
        
        writer_index.println("CONTENT BEGIN");
        writer_data.println("CONTENT BEGIN");
        
        for (int j = 0; j < all_colors.size(); j++)
        {
            String counterHex =Integer.toHexString(j);   
            // Make hex 3-digit
            if (counterHex.length() == 1) counterHex = "00" + counterHex;
            else if (counterHex.length() == 2) counterHex = "0" + counterHex;
            writer_index.println("    " + counterHex + "  :   " + all_colors.get(j) + ";");
        }

        try
        {
            second_image = ImageIO.read(file);
             
            for (int y = 0; y < second_image.getHeight(); y++) {
                for (int x = 0; x < second_image.getWidth(); x++) {
                    Color c = new Color(second_image.getRGB(x, y));
                    //System.out.println("red: " + c.getRed() + " green: " + c.getGreen() + " blue: " + c.getBlue());
                    String hexcode = String.format("%02x%02x%02x", c.getRed(),c.getGreen(),c.getBlue());
                    for (int i = 0; i < all_colors.size(); i++)
                    {
                        if (all_colors.get(i).equals(hexcode))
                        {
                            int counter = y*image.getWidth() + x;
                            String counterHex =Integer.toHexString(counter);
                    
                            // Make hex 3-digit
                            if (counterHex.length() == 1) counterHex = "00" + counterHex;
                            else if (counterHex.length() == 2) counterHex = "0" + counterHex;
                            
                            
                            String index_counter =Integer.toHexString(i);   
                            // Make hex 3-digit
                            if (index_counter.length() == 1) index_counter = "00" + index_counter;
                            else if (index_counter.length() == 2) index_counter = "0" + index_counter;

                            writer_data.println("    " + counterHex + "  :   " + index_counter + ";");
                            break;
                        }
                    }
                    
                }
                
            }
        }
                    
        catch (IOException e) 
        {
            e.printStackTrace();
        }
       
            writer_data.println("END;");
            writer_data.close();
            writer_index.println("END;");
            writer_index.close();

        } 
    
}
