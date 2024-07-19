import java.io.File;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

public class CleanUpTempFiles {

    private static final String APP_DATA_PATH = System.getenv("APPDATA");
    private static final long SIX_MONTHS_IN_MS = 6L * 30 * 24 * 60 * 60 * 1000;

    public static void main(String[] args) {
        File appDataDir = new File(APP_DATA_PATH);
        if (appDataDir.exists() && appDataDir.isDirectory()) {
            deleteOldFiles(appDataDir);
        } else {
            System.out.println("AppData directory not found.");
        }
    }

    private static void deleteOldFiles(File directory) {
        File[] files = directory.listFiles();
        if (files != null) {
            for (File file : files) {
                if (file.isFile() && file.getName().endsWith(".tmp")) {
                    if (isOldFile(file)) {
                        if (file.delete()) {
                            System.out.println("Deleted: " + file.getAbsolutePath());
                        } else {
                            System.out.println("Failed to delete: " + file.getAbsolutePath());
                        }
                    }
                }
                if (file.isDirectory()) {
                    deleteOldFiles(file);
                }
            }
        }
    }

    private static boolean isOldFile(File file) {
        long lastModified = file.lastModified();
        long currentTime = System.currentTimeMillis();
        return (currentTime - lastModified) > SIX_MONTHS_IN_MS;
    }
}
