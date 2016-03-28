package utils;

import java.io.*;
import java.util.HashSet;
import java.util.Set;

/**
 * 文件读取类
 */
public class IOUtil {

    public static Set<String> readFileToSet(String filePath, String fileEncoding) {
        if (fileEncoding == null) {
            fileEncoding = "utf-8";
        }
        File file = new File(filePath);
        BufferedReader br = null;
        String line = null;
        Set<String> lineSet = new HashSet<String>();
        try {
            br = new BufferedReader(new InputStreamReader(new FileInputStream(
                    file), fileEncoding));
            while ((line = br.readLine()) != null) {
                lineSet.add(line);
            }
            return lineSet;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (br != null) {
                try {
                    br.close();
                } catch (IOException e) {
                   e.printStackTrace();
                }
            }
        }
        return null;
    }

    public static void writeFile(String path, String value, boolean isAppend,
                                 String encoding) {
        File f = new File(path);
        // 排除其父目录不存在的情况
        FileOutputStream fos = null;
        try {
            if (isAppend) {
                fos = new FileOutputStream(f, isAppend);
            } else {
                fos = new FileOutputStream(f);
            }
            fos.write(value.getBytes(encoding));
            fos.close();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (fos != null) {
                try {
                    fos.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    public static boolean createFile(String destFileName, boolean isDelete){
        File file = new File(destFileName);
        if(file.exists()){
            if(isDelete) {
                file.delete();
            }else{
                return false;
            }
        }
        if(destFileName.endsWith(File.separator)){
            return false;
        }
        //判断目标文件所在目录是否存在
        if(!file.getParentFile().exists()){
            if(!file.getParentFile().mkdirs()){
                return false;
            }
        }
        //创建目标文件
        try{
            if(file.createNewFile()){
                return true;
            }else{
                return false;
            }
        }catch (IOException e){
            e.printStackTrace();
            return false;
        }
    }


}
