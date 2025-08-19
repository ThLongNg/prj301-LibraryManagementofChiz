/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import dto.ConfigSystem;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import mylib.DBUtils;

/**
 *
 * @author user
 */
public class SystemConfigDAO {
    public ArrayList<ConfigSystem> getAll() {
        ArrayList<ConfigSystem> list = new ArrayList<>();
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "select id,config_key,config_value,description\n"
                        + "from dbo.system_config";
                Statement st=cn.createStatement();
                ResultSet table=st.executeQuery(sql);
                if(table!=null){
                    while(table.next()){
                         int id=table.getInt("id");
                         String key=table.getString("config_key");
                         double value=table.getDouble("config_value");
                         String description=table.getString("description");
                         ConfigSystem c=new ConfigSystem(id, key, value, description);
                         list.add(c);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return list;
    }
    
    
   
}
