package action;

import utils.IOUtil;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 数据恢复action类
 */
public class RecoveryAction extends SuperAction {
    //列出当前所有的备份
    public String listback() {
        String bakPath = "C:\\Program Files\\Microsoft SQL Server\\MSSQL11.MSSQLSERVER\\MSSQL\\Backup";
        List<String> bakList = IOUtil.getFilesNameStr(bakPath);

        Map<String, String> bakFileInfo = new HashMap<String, String>();
        System.out.println(bakList.size());
        for(int i = 0; i < bakList.size(); i++){
            String fileName = "";
            String baklist = bakList.get(i).toString().split("\\$")[0];
            if(File.separator.equals("\\")){
                fileName = baklist.split("\\\\")[baklist.split("\\\\").length-1];
            }else{
                fileName = baklist.split("/")[baklist.split("/").length-1];
            }


            bakFileInfo.put(fileName,  bakList.get(i).toString().split("\\$")[1]);
        }

        session.setAttribute("bakfileinfos", bakFileInfo);

        return "baklist_success";
    }

}
