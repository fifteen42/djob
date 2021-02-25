import Principal "mo:base/Principal";

module {
    public type UserId = Principal;
    // a series of job attributes
    public type Tag = [Text];
    // salary limit
    public type Salary = (Nat, Nat); 
    
    public type NewJob = {
        title: Text;
        company: Text;
        location: Text;
        tag: Tag;
        description: Text;
        salary: Text;
        email: Text;
    };

    public type Job = {
        id: UserId;
        title: Text;
        company: Text;
        location: Text;
        tag: Tag;
        description: Text;
        salary: Text;
        email: Text;
    };
};