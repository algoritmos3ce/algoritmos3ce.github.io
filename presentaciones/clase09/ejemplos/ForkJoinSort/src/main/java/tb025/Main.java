package tb025;

import java.util.Arrays;
import java.util.concurrent.ForkJoinPool;
import java.util.concurrent.RecursiveAction;

public class Main {
    public static void main(String[] args) {
        long[] array = new long[]{80, 33, 18, 26, 51, 1, 24, 50, 31, 0, 34, 17, 88, 14, 28, 68, 79, 83, 52, 54, 53, 13, 96, 93, 10, 91, 92, 35, 65, 2, 9, 47, 16, 29, 19, 22, 15, 30, 11, 25, 27, 66, 12, 69, 95, 59, 8, 55, 6, 21, 97, 75, 39, 4, 41, 62, 42, 81, 37, 73, 86, 56, 70, 46, 49, 3, 32, 84, 98, 5, 71, 94, 76, 82, 90, 64, 67, 40, 77, 61, 87, 72, 60, 99, 23, 44, 57, 38, 20, 78, 85, 7, 74, 36, 89, 48, 43, 63, 45, 58};

        try (var executor = new ForkJoinPool()) {
            executor.execute(new SortTask(array));
        }

        System.out.println(Arrays.toString(array));
    }
}

class SortTask extends RecursiveAction {
    final long[] array;
    final int lo, hi;

    SortTask(long[] array, int lo, int hi) {
        this.array = array;
        this.lo = lo;
        this.hi = hi;
    }

    SortTask(long[] array) {
        this(array, 0, array.length);
    }

    protected void compute() {
        if (hi - lo < THRESHOLD)
            sortSequentially(lo, hi);
        else {
            int mid = (lo + hi) >>> 1;
            invokeAll(new SortTask(array, lo, mid),
                    new SortTask(array, mid, hi));
            merge(lo, mid, hi);
        }
    }

    static final int THRESHOLD = 10;

    void sortSequentially(int lo, int hi) {
        Arrays.sort(array, lo, hi);
    }

    void merge(int lo, int mid, int hi) {
        long[] buf = Arrays.copyOfRange(array, lo, mid);
        for (int i = 0, j = lo, k = mid; i < buf.length; j++)
            array[j] = (k == hi || buf[i] < array[k]) ?
                    buf[i++] : array[k++];
    }
}