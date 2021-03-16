import Array "mo:base/Array";
import Option "mo:base/Option";
import Database "./database";
import Types "./types";

module {
    type NewJob = Types.NewJob;
    type Job = Types.Job;
    type OwnerId = Types.OwnerId;

    let adminIds: [OwnerId] = [];

    public func isAdmin(ownerId: OwnerId): Bool {
        func identity(x: OwnerId): Bool { x == ownerId };
        Option.isSome(Array.find<OwnerId>(adminIds,identity))
    };

    public func hashAccess(ownerId: OwnerId, job: Job) : Bool {
        ownerId == job.ownerId or isAdmin(ownerId)
    };
};