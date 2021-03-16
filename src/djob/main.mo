import Database "./database";
import Types "./types";
import Principal "mo:base/Principal";

actor Djob {
    var directory: Database.Directory = Database.Directory();
    
    type Job = Types.Job;
    type NewJob = Types.NewJob;

    var nextId : Nat = 1;

    // Jobs
    public shared(msg) func create(newJob: NewJob): async Principal {
        directory.createOne(nextId, msg.caller, newJob);
        nextId += 1;
        msg.caller
    };

    public shared(msg) func update(job: Job): async () {
        if( msg.caller == job.id ) {
            directory.updateOne(job.id, job);
        };
    };

    public query func getAll(): async [Job] {
        directory.show()
    };

    public query func search(term: Text): async [Job] {
        directory.findBy(term)
    };

    public shared query(msg) func getOwnId(): async UserId { msg.caller };
};
