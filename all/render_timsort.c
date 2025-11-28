// render_timsort.c
typedef struct
{
    double sort_y;
    double pos_x;
    int    z;
    int    draw_order;
    int    lua_index;
} RenderFrameFFI;

static inline int cmp(const RenderFrameFFI* a, const RenderFrameFFI* b)
{
    if (a->z != b->z) return (a->z < b->z) ? -1 : 1;
    if (a->sort_y != b->sort_y) return (a->sort_y > b->sort_y) ? -1 : 1;
    if (a->draw_order != b->draw_order) return (a->draw_order < b->draw_order) ? -1 : 1;
    if (a->pos_x != b->pos_x) return (a->pos_x < b->pos_x) ? -1 : 1;
    return 0;
}

static inline void insertion_sort(RenderFrameFFI* arr, int left, int right)
{
    int i, j;
    for (i = left + 1; i < right; i++) {
        RenderFrameFFI key = arr[i];
        j = i - 1;
        while (j >= left && cmp(&key, &arr[j]) < 0) {
            arr[j + 1] = arr[j];
            j--;
        }
        arr[j + 1] = key;
    }
}

static inline int calc_minrun(int n)
{
    int r = 0;
    while (n >= 64) {
        r |= n & 1;
        n >>= 1;
    }
    return n + r;
}

static inline void reverse(RenderFrameFFI* arr, int l, int r)
{
    r--;
    while (l < r) {
        RenderFrameFFI tmp = arr[l];
        arr[l] = arr[r];
        arr[r] = tmp;
        l++; r--;
    }
}

static void merge(RenderFrameFFI* arr, RenderFrameFFI* tmp, int left, int mid, int right)
{
    int i, j, k;
    int len1 = mid - left;
    for (i = 0; i < len1; i++) tmp[i] = arr[left + i];
    i = 0; j = mid; k = left;
    while (i < len1 && j < right) {
        if (cmp(&tmp[i], &arr[j]) <= 0)
            arr[k++] = tmp[i++];
        else
            arr[k++] = arr[j++];
    }
    while (i < len1)
        arr[k++] = tmp[i++];
}

__declspec(dllexport)
void ffi_sort(RenderFrameFFI* arr, RenderFrameFFI* tmp, int n)
{
    if (n <= 1) return;

    int run_starts[128];
    int run_lens[128];
    int run_top = 0;
    int minrun = calc_minrun(n);
    int i = 0;

    while (i < n) {
        int start = i;
        int end = i + 1;

        if (end < n && cmp(&arr[end], &arr[start]) < 0) {
            while (end < n && cmp(&arr[end], &arr[end - 1]) < 0)
                end++;
            reverse(arr, start, end);
        } else {
            while (end < n && cmp(&arr[end], &arr[end - 1]) >= 0)
                end++;
        }

        int run_len = end - start;
        if (run_len < minrun) {
            int extend = minrun;
            if (start + extend > n) extend = n - start;
            insertion_sort(arr, start, start + extend);
            end = start + extend;
            run_len = extend;
        }

        run_starts[run_top] = start;
        run_lens[run_top] = run_len;
        run_top++;

        i = end;

        while (run_top > 1) {
            int A = run_lens[run_top - 1];
            int B = run_lens[run_top - 2];
            int C = (run_top > 2) ? run_lens[run_top - 3] : 2147483647;

            int cond1 = (run_top > 2 && C <= A + B);
            int cond2 = (B <= A);

            if (cond1 || cond2) {
                int merge_idx;
                if (cond1 && C < A) merge_idx = run_top - 3;
                else merge_idx = run_top - 2;

                int left  = run_starts[merge_idx];
                int mid   = run_starts[merge_idx + 1];
                int right = mid + run_lens[merge_idx + 1];

                merge(arr, tmp, left, mid, right);
                run_lens[merge_idx] += run_lens[merge_idx + 1];
                for (int t = merge_idx + 1; t < run_top - 1; t++) {
                    run_starts[t] = run_starts[t + 1];
                    run_lens[t] = run_lens[t + 1];
                }
                run_top--;
            } else break;
        }
    }

    while (run_top > 1) {
        int left  = run_starts[run_top - 2];
        int mid   = run_starts[run_top - 1];
        int right = mid + run_lens[run_top - 1];
        merge(arr, tmp, left, mid, right);
        run_lens[run_top - 2] += run_lens[run_top - 1];
        run_top--;
    }
}
