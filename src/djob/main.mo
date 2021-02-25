import Database "./database";
import Types "./types";
import Principal "mo:base/Principal";

actor Djob {
    var directory: Database.Directory = Database.Directory();

    type NewJob = Types.NewJob;
    type Job = Types.Job;
    type UserId = Types.UserId;

    // Jobs

    public shared(msg) func create(job: NewJob): async Principal {
        directory.createOne(msg.caller, job);
        msg.caller
    };

    public shared(msg) func update(job: Job): async () {
        if( msg.caller == job.id ) {
            directory.updateOne(job.id, job);
        };
    };

    public query func get(userId: UserId): async ?Job {
        directory.findOne(userId)
    };

    public query func search(term: Text): async [Job] {
        directory.findBy(term)
    };

    public shared query(msg) func getOwnId(): async UserId { msg.caller };

};
