// Perform and log output of simple arithmetic operations
func simple_math() {
   // adding 13 +  14
   tempvar add = 13 + 14;
   %{
    print(ids.add)
   %}

   // multiplying 3 * 6
   tempvar mult = 3 * 6;
   %{
    print(ids.mult)
   %}

   // dividing 6 by 2
   tempvar div1 = 6 / 2;
   %{
    print(ids.div1)
   %}

   // dividing 70 by 2
   tempvar div2 = 70 / 2;
   %{
    print(ids.div2)
   %}

   // dividing 7 by 2
   tempvar div3 = 7 / 2;
   %{
    print(ids.div3)
   %}

    return ();
}
