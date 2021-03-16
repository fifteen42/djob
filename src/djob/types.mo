module {
    public type OwnerId = Principal;
    public type Tag = [Text];

    public type NewJob = {
        title: Text;
        company: Text;
        location: Text;
        tag: Tag;
        description: Text;
        salaryFloor: Nat;
        salaryCeiling: Nat;
        email: Text;
    };

    public type Job = {
        id: Nat;
        ownerId: OwnerId;
        title: Text;
        company: Text;
        location: Text;
        tag: Tag;
        description: Text;
        salaryFloor: Nat;
        salaryCeiling: Nat;
        email: Text;
    };
};