import Database "./database";
import Types "./types";
import Principal "mo:base/Principal";
import Nat "mo:base/Nat";

actor Djob {
    var directory: Database.Directory = Database.Directory();
    
    type Job = Types.Job;
    type NewJob = Types.NewJob;
    type OwnerId = Types.OwnerId;
    
    let my_id:Text = "rbyiv-go2kc-uqegy-mron3-mca6w-u42ww-tz7v7-zz7om-hpbov-ozqax-yqe";


    var nextId : Nat = 1;

    public shared(msg) func create(newJob: NewJob): async Text {
        directory.createOne(nextId, newJob);
        nextId += 1;
        let s_id = Nat.toText(nextId - 1);
        return "You crate a job with id : " # s_id;
    };

    public shared(msg) func update(job: Job): async () {
        directory.updateOne(job.id, job);
    };

    public shared(msg) func delete(jobId: Nat): async () {
        directory.deleteOne(jobId);
    };

    public query func get(jobId: Nat): async ?Job {
        directory.findOne(jobId)
    };

    public query func getAll(): async [Job] {
        directory.show()
    };

    public query func getAllD(): async [Job] {
        directory.showAll()
    };

    public query func search(term: Text): async [Job] {
        directory.findBy(term)
    };

    public shared query(msg) func getOwnId(): async OwnerId { my_id };
};
