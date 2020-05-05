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
public class Mif_generator {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) throws FileNotFoundException, UnsupportedEncodingException {
        
        // Change this
        String file_url_a = "C:\\Users\\noahp\\Desktop\\mif_gen\\char\\a.png";
        String file_url_b = "C:\\Users\\noahp\\Desktop\\mif_gen\\char\\b.png";
        String file_url_c = "C:\\Users\\noahp\\Desktop\\mif_gen\\char\\c.png";
        String file_url_d = "C:\\Users\\noahp\\Desktop\\mif_gen\\char\\d.png";
        String file_url_e = "C:\\Users\\noahp\\Desktop\\mif_gen\\char\\e.png";
        String file_url_f = "C:\\Users\\noahp\\Desktop\\mif_gen\\char\\f.png";
        String file_url_g = "C:\\Users\\noahp\\Desktop\\mif_gen\\char\\g.png";
        String file_url_h = "C:\\Users\\noahp\\Desktop\\mif_gen\\char\\h.png";
        String file_url_i = "C:\\Users\\noahp\\Desktop\\mif_gen\\char\\i.png";
        String file_url_j = "C:\\Users\\noahp\\Desktop\\mif_gen\\char\\j.png";
        String file_url_k = "C:\\Users\\noahp\\Desktop\\mif_gen\\char\\k.png";
        String file_url_l = "C:\\Users\\noahp\\Desktop\\mif_gen\\char\\l.png";
        String file_url_m = "C:\\Users\\noahp\\Desktop\\mif_gen\\char\\m.png";
        String file_url_n = "C:\\Users\\noahp\\Desktop\\mif_gen\\char\\n.png";
        String file_url_o = "C:\\Users\\noahp\\Desktop\\mif_gen\\char\\o.png";
        String file_url_p = "C:\\Users\\noahp\\Desktop\\mif_gen\\char\\p.png";
        String file_url_q = "C:\\Users\\noahp\\Desktop\\mif_gen\\char\\q.png";
        String file_url_r = "C:\\Users\\noahp\\Desktop\\mif_gen\\char\\r.png";
        String file_url_s = "C:\\Users\\noahp\\Desktop\\mif_gen\\char\\s.png";
        String file_url_t = "C:\\Users\\noahp\\Desktop\\mif_gen\\char\\t.png";
        String file_url_u = "C:\\Users\\noahp\\Desktop\\mif_gen\\char\\u.png";
        String file_url_v = "C:\\Users\\noahp\\Desktop\\mif_gen\\char\\v.png";
        String file_url_w = "C:\\Users\\noahp\\Desktop\\mif_gen\\char\\w.png";
        String file_url_x = "C:\\Users\\noahp\\Desktop\\mif_gen\\char\\x.png";
        String file_url_y = "C:\\Users\\noahp\\Desktop\\mif_gen\\char\\y.png";
        String file_url_z = "C:\\Users\\noahp\\Desktop\\mif_gen\\char\\z.png";
        
        ArrayList<String> all_letters = new ArrayList<String>();
        all_letters.add(file_url_a);
        all_letters.add(file_url_b);
        all_letters.add(file_url_c);
        all_letters.add(file_url_d);
        all_letters.add(file_url_e);
        all_letters.add(file_url_f);
        all_letters.add(file_url_g);
        all_letters.add(file_url_h);
        all_letters.add(file_url_i);
        all_letters.add(file_url_j);
        all_letters.add(file_url_k);
        all_letters.add(file_url_l);
        all_letters.add(file_url_m);
        all_letters.add(file_url_n);
        all_letters.add(file_url_o);
        all_letters.add(file_url_p);
        all_letters.add(file_url_q);
        all_letters.add(file_url_r);
        all_letters.add(file_url_s);
        all_letters.add(file_url_t);
        all_letters.add(file_url_u);
        all_letters.add(file_url_v);
        all_letters.add(file_url_w);
        all_letters.add(file_url_x);
        all_letters.add(file_url_y);
        all_letters.add(file_url_z);
        
        String index_a = "a_index";
        String index_b = "b_index";
        String index_c = "c_index";
        String index_d = "d_index";
        String index_e = "e_index";
        String index_f = "f_index";
        String index_g = "g_index";
        String index_h = "h_index";
        String index_i = "i_index";
        String index_j = "j_index";
        String index_k = "k_index";
        String index_l = "l_index";
        String index_m = "m_index";
        String index_n = "n_index";
        String index_o = "o_index";
        String index_p = "p_index";
        String index_q = "q_index";
        String index_r = "r_index";
        String index_s = "s_index";
        String index_t = "t_index";
        String index_u = "u_index";
        String index_v = "v_index";
        String index_w = "w_index";
        String index_x = "x_index";
        String index_y = "y_index";
        String index_z = "z_index";

        ArrayList<String> all_indices = new ArrayList<String>();
        all_indices.add(index_a);
        all_indices.add(index_b);
        all_indices.add(index_c);
        all_indices.add(index_d);
        all_indices.add(index_e);
        all_indices.add(index_f);
        all_indices.add(index_g);
        all_indices.add(index_h);
        all_indices.add(index_i);
        all_indices.add(index_j);
        all_indices.add(index_k);
        all_indices.add(index_l);
        all_indices.add(index_m);
        all_indices.add(index_n);
        all_indices.add(index_o);
        all_indices.add(index_p);
        all_indices.add(index_q);
        all_indices.add(index_r);
        all_indices.add(index_s);
        all_indices.add(index_t);
        all_indices.add(index_u);
        all_indices.add(index_v);
        all_indices.add(index_w);
        all_indices.add(index_x);
        all_indices.add(index_y);
        all_indices.add(index_z);
        
        String data_a = "a_data";
        String data_b = "b_data";
        String data_c = "c_data";
        String data_d = "d_data";
        String data_e = "e_data";
        String data_f = "f_data";
        String data_g = "g_data";
        String data_h = "h_data";
        String data_i = "i_data";
        String data_j = "j_data";
        String data_k = "k_data";
        String data_l = "l_data";
        String data_m = "m_data";
        String data_n = "n_data";
        String data_o = "o_data";
        String data_p = "p_data";
        String data_q = "q_data";
        String data_r = "r_data";
        String data_s = "s_data";
        String data_t = "t_data";
        String data_u = "u_data";
        String data_v = "v_data";
        String data_w = "w_data";
        String data_x = "x_data";
        String data_y = "y_data";
        String data_z = "z_data";

        ArrayList<String> all_datas = new ArrayList<String>();
        all_datas.add(data_a);
        all_datas.add(data_b);
        all_datas.add(data_c);
        all_datas.add(data_d);
        all_datas.add(data_e);
        all_datas.add(data_f);
        all_datas.add(data_g);
        all_datas.add(data_h);
        all_datas.add(data_i);
        all_datas.add(data_j);
        all_datas.add(data_k);
        all_datas.add(data_l);
        all_datas.add(data_m);
        all_datas.add(data_n);
        all_datas.add(data_o);
        all_datas.add(data_p);
        all_datas.add(data_q);
        all_datas.add(data_r);
        all_datas.add(data_s);
        all_datas.add(data_t);
        all_datas.add(data_u);
        all_datas.add(data_v);
        all_datas.add(data_w);
        all_datas.add(data_x);
        all_datas.add(data_y);
        all_datas.add(data_z);

        for (int k = 0; k < all_letters.size(); k++) {
            String image_name = "test circle";
            HashSet<String> hset = new HashSet<String>();

            // Shouldn't have to change this:
            String address_radix = "ADDRESS_RADIX=HEX;";
            String data_radix = "DATA_RADIX=HEX;";
            //

            File file = new File(all_letters.get(k));
            BufferedImage image = null;
            BufferedImage second_image = null;
            PrintWriter writer_index = new PrintWriter("C:\\Users\\noahp\\Desktop\\mif_gen\\" + all_indices.get(k) + ".mif", "UTF-8");
            PrintWriter writer_data = new PrintWriter("C:\\Users\\noahp\\Desktop\\mif_gen\\" + all_datas.get(k) + ".mif", "UTF-8");

            try {
                image = ImageIO.read(file);

                for (int y = 0; y < image.getHeight(); y++) {
                    for (int x = 0; x < image.getWidth(); x++) {
                        Color c = new Color(image.getRGB(x, y));
                        //System.out.println("red: " + c.getRed() + " green: " + c.getGreen() + " blue: " + c.getBlue());
                        String hexcode = String.format("%02x%02x%02x", c.getRed(), c.getGreen(), c.getBlue());
                        hset.add(hexcode);
                    }

                }
            } catch (IOException e) {
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

            for (int j = 0; j < all_colors.size(); j++) {
                String counterHex = Integer.toHexString(j);
                // Make hex 3-digit
                if (counterHex.length() == 1) {
                    counterHex = "00" + counterHex;
                } else if (counterHex.length() == 2) {
                    counterHex = "0" + counterHex;
                }
                writer_index.println("    " + counterHex + "  :   " + all_colors.get(j) + ";");
            }

            try {
                second_image = ImageIO.read(file);

                for (int y = 0; y < second_image.getHeight(); y++) {
                    for (int x = 0; x < second_image.getWidth(); x++) {
                        Color c = new Color(second_image.getRGB(x, y));
                        //System.out.println("red: " + c.getRed() + " green: " + c.getGreen() + " blue: " + c.getBlue());
                        String hexcode = String.format("%02x%02x%02x", c.getRed(), c.getGreen(), c.getBlue());
                        for (int i = 0; i < all_colors.size(); i++) {
                            if (all_colors.get(i).equals(hexcode)) {
                                int counter = y * image.getWidth() + x;
                                String counterHex = Integer.toHexString(counter);

                                // Make hex 3-digit
                                if (counterHex.length() == 1) {
                                    counterHex = "00" + counterHex;
                                } else if (counterHex.length() == 2) {
                                    counterHex = "0" + counterHex;
                                }

                                String index_counter = Integer.toHexString(i);
                                // Make hex 3-digit
                                if (index_counter.length() == 1) {
                                    index_counter = "00" + index_counter;
                                } else if (index_counter.length() == 2) {
                                    index_counter = "0" + index_counter;
                                }

                                writer_data.println("    " + counterHex + "  :   " + index_counter + ";");
                                break;
                            }
                        }

                    }

                }
            } catch (IOException e) {
                e.printStackTrace();
            }

            writer_data.println("END;");
            writer_data.close();
            writer_index.println("END;");
            writer_index.close();

        }
    }
    
}
