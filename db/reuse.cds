namespace com.ey.reuse;

//Reusable types
type Guid: String(32);
//Resusable aspects - structures - group of fields
aspect Address {
    street: String(32);
    landmark: String(48);
    city: String(32);
    country: String(2);
}

