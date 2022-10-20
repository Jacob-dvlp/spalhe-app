formatToNumberString(int n) {
  if (n < 1e3) return n.toString();
  if (n >= 1e3) return (n / 1e3).toString().split('.')[0] + "K";
}
